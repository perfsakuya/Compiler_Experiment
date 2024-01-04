%{
/* 包含所需头文件 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "header.h"
#define YYSTYPE node

codelist* list; // 一些需要的数据实现
char* prog_name;
extern int yylineno;
extern char* yytext;
extern int yylex();    
extern int iserror = 0;
%}

/* 声明 token 供后续使用, 同时也可以在 lex 中使用 */
%token AND ARR BEG BOOL CALL CASE CHR CONST DIM DO ELSE END BOOLFALSE FOR IF INPUT INT NOT OF OR OUTPUT PROCEDURE PROGRAM READ REAL REPEAT SET STOP THEN TO BOOLTRUE UNTIL VAR WHILE WRITE RELOP
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

%start program

%%

// ---------------------------1 程序定义--------------------------------------
// 1.1 <程序> → program <标识符> ; | program
program : PROGRAM program_name SEMI program
        
            | VAR var_definition program
            {
                // printf("\033[36m[info]\033[0m Variable Declaration: of type integer.\n"); // 只作提示，以后要删除
            }
            | BEG statement
            {
                // printf("\033[36m[info]\033[0m BEGIN\n"); // 只作提示，以后要删除
            }
            ;

program_name : id {
    prog_name = $1.lexeme;
    // printf("(%d) (program,%s,-,-)\n", quad_ruple_count, $1.lexeme); // 弃用的输出
                  }
                  ;
                  
var_definition : id COMMA var_definition
                | id COLON INT SEMI var_definition
                {
                    // printf("\033[36m[info]\033[0m FINISH VAR\n"); // 只作提示，以后要删除
                }
                | {}
                ;
// --------------------------------------------------------------------------


// ---------------------------2 语句定义--------------------------------------
// <语句> → <赋值句>│<if句>│<while句>│<repeat句>│<复合句>
statement : IF expression THEN M statement 
            {
                backpatch(list, $2.truelist, $4.instr);
                $$.nextlist = merge($2.falselist, $5.nextlist); 
            }

            |IF expression THEN M statement ELSE N M statement
            {
                backpatch(list, $2.truelist, $4.instr);    
                backpatch(list, $2.falselist, $8.instr);
                $5.nextlist = merge($5.nextlist, $7.nextlist);    
                $$.nextlist = merge($5.nextlist, $9.nextlist);
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
            |{}
            ;

L   :   L SEMI M statement
        {
            backpatch(list, $1.nextlist, $3.instr);
            $$.nextlist = $4.nextlist;
        }
        |L END DOT M
        {
            backpatch(list,$1.nextlist,$4.instr);
            // printf("\033[36m[info]\033[0m FINISH PROGRAM\n"); // 只作提示，以后要删除
            YYACCEPT; // 结束
        }
        |statement
        {
            $$.nextlist = $1.nextlist;
        }
        ;

// RELOP 为各种表达
// "<"|"<="|">"|">="|"!="|"=" 
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

calc_expression :   INTEGER 
                {
                    copyaddr(&$$, $1.lexeme);
                }

                |calc_expression ADD calc_expression 
                {
                    new_temp(&$$, get_temp_index(list));
                    gen_3addr(list, $$, $1, " +", $3);
                }

                |calc_expression SUB calc_expression 
                {
                    new_temp(&$$, get_temp_index(list));
                    gen_3addr(list, $$, $1, " -", $3);
                }
                |calc_expression MUL calc_expression 
                {
                    new_temp(&$$, get_temp_index(list)); 
                    gen_3addr(list, $$, $1, " *", $3);
                }

                |calc_expression DIV calc_expression 
                {
                    new_temp(&$$, get_temp_index(list)); 
                    gen_3addr(list, $$, $1, " /", $3);
                }
                |id 
                {
                    copyaddr(&$$, $1.lexeme);
                }
                ;
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

void printTitleAndDesigners() {
    // 非常cool的标题
    printf("\033[35m   _____ ______  _______  __    ______     ___    _   _____    ____  _______   __________ \n");
    printf("  / ___//  _/  |/  / __ \\/ /   / ____/    /   |  / | / /   |  / /\\ \\/ /__  /  / ____/ __ \\ \n");
    printf("  \\__ \\ / // /|_/ / /_/ / /   / __/      / /| | /  |/ / /| | / /  \\  /  / /  / __/ / /_/ /\n");
    printf(" ___/ // // /  / / ____/ /___/ /___     / ___ |/ /|  / ___ |/ /___/ /  / /__/ /___/ _, _/ \n");
    printf("/____/___/_/  /_/_/   /_____/_____/    /_/  |_/_/ |_/_/  |_/_____/_/  /____/_____/_/ |_|  v1.0.0\n");
    printf("────────────────────────────────────────────────────────────────────────────────────────────────\033[0m\n");
    // 制作人员公示
    printf("┌───────────────────────┐\n");
    printf("│ANALYZER MADE BY:      │\n");
    printf("│汤骏哲     202230444429│\n");
    printf("│黄泽川     202230441183│\n");
    printf("│马思捷     202230140314│\n");
    printf("└───────────────────────┘\n");
}

int main() {
    char input_name[100];
    extern FILE *yyin;
    list = newcodelist();
    printTitleAndDesigners();


    printf("\033[36m[info]\033[0m Text your program name here:\n");

    // 读取源文件
    if (scanf("%99s", input_name) != 1) {
        fprintf(stderr, "\033[31m[error]\033[0m Process terminated.\n");
        return 1;  // ctrl+c关闭了程序
    }
    FILE* input_file = freopen(input_name, "rt+", stdin);
    if (input_file == NULL) {
        fprintf(stderr, "\033[31m[error]\033[0m No such file: %s\n", input_name);
        return 2;  // 输入了不存在的文件名
    }

    // 分析开始
    printf("\033[36m[info]\033[0m START ANALYZING.\n");
    yyparse();

    // 信息输出
    if(iserror == 1)
        printf("\033[31m[error]\033[0m Process terminated.\n");
    else {
        print(list, prog_name);
        printf("\033[32m[info]\033[0m ANALYZE SUCCESSFULLY.\n");
    }

    return 0;
}

// Linux 下注释掉这个函数
int yyerror(char *msg) {
    // 输出错误信息的行数和错误的token
    fprintf(stderr, "\033[31m[%s]\033[0m at line %d. Unexpected character: %s\n",msg, yylineno, removeNewline(yytext)); 
    iserror = 1;
    return 0;
}
// Linux 下注释掉这个函数
int yywrap(){
    return 1;
}