%{
/* 包含所需头文件 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "try.h"
#define YYSTYPE node
codelist* list;

int quad_ruple_count = 0; // 地址计数
extern int yylineno;
extern char* yytext;
extern int yylex();    
// int yyerror();
// int yyerror(char* msg);
%}

/* 声明 token 供后续使用, 同时也可以在 lex 中使用 */
%token LF AND ARR BEG BOOL CALL CASE CHR CONST DIM DO ELSE END BOOLFALSE FOR IF INPUT INT NOT OF OR OUTPUT PROCEDURE PROGRAM READ REAL REPEAT SET STOP THEN TO BOOLTRUE UNTIL VAR WHILE WRITE RELOP
%token LB RB RCOMMENT LCOMMENT COMMA DOT TDOT COLON ASSIGN SEMI LT LE NE EQ RT RE LC RC
%token INTEGER id TRUECHAR FALSECHAR TRUECOMMENT FALSECOMMENT ILLEGALCHR

/* %left 表示左结合, %right 表示右结合 */
/* 最后列出的定义具有最高的优先级 */
%left ADD SUB
%left MUL DIV 

%left OR
%left AND
%right NOT
%left '+' '-'
%left '*' '/'
%right '='
%right ASSIGN
%nonassoc WITHOUT_ELSE


/* 定义结构体, 使得 token 可以附带相应的数据信息(语义值) */
// 暂时不需要
// %union {
//     int num;
//     char *str;
//     int boolvalue; // 0==false, 1==true
// }

/* 指明不同 token 或者 规则 的数据类型 */
// %type <num> INTEGER assignment_statement meta_assignment 
// %type <str> program_name id variable_list calc_expression var_definition 
// %type <boolvalue> bool_expression
/* 根据规定，YACC仅对第一条规则感兴趣, 或者使用 %start 符号指定的起始规则 */
%start program

%%

// ---------------------------1 程序定义--------------------------------------
// 1.1 <程序> → program <标识符> ; | program
program:    PROGRAM program_name SEMI LF program
        
            | VAR var_definition program
            {
                printf("[info] Variable Declaration: of type integer.\n"); // 只作提示，以后要删除
            }
            | BEG LF statement
            {
                printf("[info] BEGIN\n"); // 只作提示，以后要删除
            }
            ;

program_name: id {
    printf("(%d) (program,%s,-,-)\n", quad_ruple_count, $1.lexeme);
};
var_definition : id COMMA var_definition
                | id COLON INT SEMI var_definition
                {
                    printf("[info] FINISH VAR\n"); // 只作提示，以后要删除
                }
                | LF
                | {}
                ;
// --------------------------------------------------------------------------


// ---------------------------2 语句定义--------------------------------------
// 2.0 <语句> → <赋值句>│<if句>│<while句>│<repeat句>│<复合句>
// <<<这里的各种_statement都不需要识别换行符LF和分号SEMI>>>
statement : IF expression THEN M statement %prec WITHOUT_ELSE
            {
                backpatch(list, $2.truelist, $4.instr);
                $$.nextlist = merge($2.falselist, $5.nextlist); 
            }

            |IF expression THEN M statement ELSE LF N M statement
            {
                backpatch(list, $2.truelist, $4.instr);    
                backpatch(list, $2.falselist, $9.instr);
                $5.nextlist = merge($5.nextlist, $8.nextlist);    
                $$.nextlist = merge($5.nextlist, $10.nextlist);
            }

            |WHILE M expression DO M statement
            {
                backpatch(list, $6.nextlist, $2.instr);    
                backpatch(list, $3.truelist, $5.instr);
                $$.nextlist = $3.falselist; 
                gen_goto(list, $2.instr);
            }

            |REPEAT M statement UNTIL M expression M statement
            {
                backpatch(list,$3.nextlist, $5.instr);
                backpatch(list, $6.falselist, $2.instr);
                backpatch(list, $6.truelist, $7.instr);
            }

            |calc_expression ASSIGN expression
            {
                copyaddr(&$1, $1.lexeme); 
                gen_assignment(list, $1, $3);
            }

            |L
            {
                $$.nextlist = $1.nextlist;
            }
            |LF statement 
            {
                $$.nextlist = $2.nextlist;
            }
            |END DOT LF
            {
                //差一个回填backpatch即可完成
                printf("[info] FINISH PROGRAM\n"); // 只作提示，以后要删除
                YYACCEPT; // 结束
            }
            |{}
            ;

L   :   L SEMI M statement
        {
            backpatch(list, $1.nextlist, $3.instr);
            $$.nextlist = $4.nextlist;
        }
        |statement
        {
            $$.nextlist = $1.nextlist;
        }
        ;
// 改成expression形式 分为布尔 AND OR NOT RELOP 与calc_expression

// RELOP 为各种表达
// "<"|"<="|">"|">="|"!="|"="    { filloperator(&yylval, yytext); return( RELOP ); }
expression   :   expression AND M expression    
        {   
            backpatch(list, $1.truelist, $3.instr);
            $$.truelist = $4.truelist; 
            $$.falselist = merge($1.falselist, $4.falselist); 
        }
        |expression OR M expression
        {
            backpatch(list, $1.falselist, $3.instr);
            $$.falselist = $4.falselist; 
            $$.truelist = merge($1.truelist, $4.truelist); 
        }
        |NOT expression
        {
            $$.truelist = $2.falselist;
            $$.falselist = $2.truelist;
        }

        |calc_expression RELOP calc_expression
        {   
            $$.truelist = new_instrlist(nextinstr(list));
            $$.falselist = new_instrlist(nextinstr(list)+1);
            gen_if(list, $1, $2.oper, $3);
            gen_goto_blank(list); 
        }
                
        |calc_expression
        {
            copyaddr_fromnode(&$$, $1);
        }
        ;
// 一些辅助符号

calc_expression: INTEGER 
                {
                    copyaddr(&$$, $1.lexeme);
                }

                |calc_expression ADD calc_expression 
                {
                    new_temp(&$$, get_temp_index(list));
                    gen_3addr(list, $$, $1, "+", $3);
                }

                |calc_expression SUB calc_expression 
                {
                    new_temp(&$$, get_temp_index(list));
                    gen_3addr(list, $$, $1, "-", $3);
                }
                |calc_expression MUL calc_expression 
                {
                    new_temp(&$$, get_temp_index(list)); 
                    gen_3addr(list, $$, $1, "*", $3);
                }

                |calc_expression DIV calc_expression 
                {
                    new_temp(&$$, get_temp_index(list)); 
                    gen_3addr(list, $$, $1, "/", $3);
                }
                |id 
                {
                    copyaddr(&$$, $1.lexeme);
                };


M   :   { $$.instr = nextinstr(list); }
        ;

N   :   {
            $$.nextlist = new_instrlist(nextinstr(list));
            gen_goto_blank(list);
        }
        ;

%%

char* removeNewline(char *str) {
    size_t length = strlen(str);

    if (length > 0) {
        // Check if the last character is a newline character
        if (str[length - 1] == '\n') {
            // Replace the newline character with a null terminator
            str[length - 1] = '\0';
        }
    } else {
        // If the string is empty, set it to NULL
        free(str);
        str = strdup("null");
    }

    return str;
}

int main() {
    list = newcodelist();

    // 这里改了一下，直接在cmd里面输出，方便调试，以后可以改回来
    // freopen("test_program.txt", "rt+", stdin);
    // freopen("test.out", "wt+", stdout);
    extern FILE *yyin;
    yyin = stdin;
    yyparse();
    print(list);
    

    fclose(stdin);
    fclose(stdout);
    return 0;
}

// Linux 下注释掉这个函数
int yyerror(char *msg) {
    fprintf(stderr, "[%s] encountered at line %d.\nUnexpected character is: %s\n",msg, yylineno, removeNewline(yytext)); // 输出错误信息的行数和错误的token
    return 0;
}
// Linux 下注释掉这个函数
int yywrap(){
    return 1;
}