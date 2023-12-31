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
%token LF AND ARR BEG BOOL CALL CASE CHR CONST DIM DO ELSE END BOOLFALSE FOR IF INPUT INT NOT OF OR OUTPUT PROCEDURE PROGRAM READ REAL REPEAT SET STOP THEN TO BOOLTRUE UNTIL VAR WHILE WRITE 
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
                | id COLON INT LF
                {
                    printf("[info] FINISHI VAR\n"); // 只作提示，以后要删除
                }
// --------------------------------------------------------------------------


// ---------------------------2 语句定义--------------------------------------
// 2.0 <语句> → <赋值句>│<if句>│<while句>│<repeat句>│<复合句>
// <<<这里的各种_statement都不需要识别换行符LF和分号SEMI>>>
statement: assignment_statement {
    printf("[info] Processed assignment.\n"); // 只作提示，以后要删除
} | if_statement {
    printf("[info] Processed if.\n"); // 只作提示，以后要删除
} | while_statement {
    printf("[info] Processed while.\n"); // 只作提示，以后要删除
} | repeat_statement {
    printf("[info] Processed while.\n"); // 只作提示，以后要删除
} | complex_statement {
    printf("[info] Processed complex.\n"); // 只作提示，以后要删除
};

// 2.1 <复合句> → begin <语句表> end
complex_statement: begin statement_list end;
// 2.1.a.begin开始符号
begin: BEG LF {
    printf("[info] Beginning main part.\n"); // 只作提示，以后要删除
};
// 2.1.b.end结束符号
end: END DOT LF {
    printf("(%d) (sys , - , - , - )\n", quad_ruple_count);
    printf("[info] Ending main part.\n"); // 只作提示，以后要删除
    YYACCEPT;
};

// 2.2 <语句表> → <语句> ; <语句表>│<语句> 这里做了一点修改以匹配其他语句
statement_list: statement SEMI statement_list | statement SEMI LF statement_list | ;

// 2.3 <赋值句> → <标识符> := <算术表达式>
assignment_statement: id ASSIGN calc_expression {
    // 输出赋值的四元式
    copyaddr(&$1, $1.lexeme);
    gen_assignment(list, $1, $3);
    // 这里储存变量的值（后续如果有需要的话）（作业中不用实现）
};    
// <<<bug备份>>>
// assignment_statement: meta_assignment {

//     $$ = $1;
// } | meta_assignment SEMI assignment_statement{
//     $$ = $1;
// };
// meta_assignment: id ASSIGN calc_expression {
//     // 输出赋值的四元式
//     printf("(%d) (:=, %s , - , %s)\n",quad_ruple_count, $3, $1);
//     quad_ruple_count++;
//     // 这里储存变量的值（后续如果有需要的话）（作业中不用实现）
// };


// <<<我们要用tiny.h中的backpatch和merge进行操作，从而达到状态转移的效果>>>
// <<<未完成部分>>>
// 2.4 <if句>→ if <布尔表达式> then <语句>│if <布尔表达式> then <语句> else <语句>

if_statement: IF bool_comparison THEN M statement %prec WITHOUT_ELSE {  // 消除冲突
    backpatch(list, $2.truelist, $4.instr);
    $$.nextlist = $5.nextlist;
} | IF bool_comparison THEN M statement ELSE N M statement { 
    backpatch(list, $2.truelist, $4.instr);    
    backpatch(list, $2.falselist, $8.instr);
    $5.nextlist = merge($5.nextlist, $7.nextlist);    
    $$.nextlist = merge($5.nextlist, $9.nextlist);
};

// 2.5 <while句> → while <布尔表达式> do <语句>
while_statement: WHILE M bool_comparison DO M statement {
    backpatch(list, $6.nextlist, $2.instr);    
    backpatch(list, $3.truelist, $5.instr);
    $$.nextlist = $3.falselist; 
    gen_goto(list, $2.instr);
};

// 2.6 <repeat句> → repeat <语句> until <布尔表达式>
repeat_statement: REPEAT M statement UNTIL M bool_expression M {
    backpatch(list,$3.nextlist, $5.instr);
    backpatch(list, $6.falselist, $2.instr);
    backpatch(list, $6.truelist, $7.instr);
    // backpatch(list, $5.falselist, $2.instr);
    // backpatch(list, $5.truelist, $6instr);
};

// --------------------------------------------------------------------------


// ---------------------------3 表达式定义------------------------------------
// 3.1 算术表达式
calc_expression: INTEGER {
    // char* temp = (char*)malloc(20);  // 动态分配空间
    // // snprintf(temp, 20, "%d", $1);    // 转换成str再传参
    // $$ = strdup(temp);  // <<<BUG>>>
    copyaddr(&$$, $1.lexeme);
} | id {
    // $$ = strdup($1); // 本身就是str，直接传值 // <<<BUG>>>
    copyaddr(&$$, $1.lexeme);

} | calc_expression ADD calc_expression {
    new_temp(&$$, get_temp_index(list));
    gen_3addr(list, $$, $1, "+", $3);

} | calc_expression SUB calc_expression {
    new_temp(&$$, get_temp_index(list));
    gen_3addr(list, $$, $1, "-", $3);

} | calc_expression MUL calc_expression {
    new_temp(&$$, get_temp_index(list)); 
    gen_3addr(list, $$, $1, "*", $3);

} | calc_expression DIV calc_expression {
    new_temp(&$$, get_temp_index(list)); 
    gen_3addr(list, $$, $1, "/", $3);
};

// <<<未完成部分>>>
// 3.2 <布尔表达式> → <布尔项> or <布尔表达式>│<布尔项> 这里反过来了一下，防止左递归
bool_expression: bool_1 OR M bool_expression {
    backpatch(list, $1.truelist, $3.instr);
            $$.falselist = $4.falselist; 
            $$.truelist = merge($1.truelist, $4.truelist); 
} | bool_1 {

};
// <布尔项> → <布因子> and <布尔项> │ <布因子>
bool_1: bool_1 AND M bool_2 {
    backpatch(list, $1.falselist, $3.instr);
    $$.truelist = $4.truelist; 
    $$.falselist = merge($1.falselist, $4.falselist); 
} | bool_2 {

};
// <布因子> → <布尔量> │ not <布因子>
bool_2: bool_3 {

} | NOT bool_2 {
    $$.falselist = $2.truelist; 
    $$.truelist = $2.falselist;
};
// <布尔量> → <布尔常量>(未使用)│<标识符>│（ <布尔表达式> ）│ ...↓...
// 这不会递归？
bool_3:  LB bool_expression RB {

} | bool_comparison { // <标识符> <关系符> <标识符>│<算术表达式> <关系符> <算术表达式>

};
// bool_value: BOOLTRUE {
//     $$ = $1;
// }| BOOLFALSE {
//     $$ = $1;
// };

// 3.3 <布尔量> → <标识符> <关系符> <标识符>│<算术表达式> <关系符> <算术表达式>
bool_comparison: calc_expression LT calc_expression {
    $$.truelist = new_instrlist(nextinstr(list));
    $$.falselist = new_instrlist(nextinstr(list)+1);
    char op[1]={"<"};
    gen_if(list, $1, op, $3);
    gen_goto_blank(list);
    
} | calc_expression LE calc_expression {
    $$.truelist = new_instrlist(nextinstr(list));
    $$.falselist = new_instrlist(nextinstr(list)+1);
    char op[2]={"<="};
    gen_if(list, $1, op, $3);
    gen_goto_blank(list);
    
} | calc_expression RT calc_expression {
    $$.truelist = new_instrlist(nextinstr(list));
    $$.falselist = new_instrlist(nextinstr(list)+1);
    char op[1]={">"};
    gen_if(list, $1, op, $3);
    gen_goto_blank(list);
    
} | calc_expression RE calc_expression {
    $$.truelist = new_instrlist(nextinstr(list));
    $$.falselist = new_instrlist(nextinstr(list)+1);
    char op[2]={">="};
    gen_if(list, $1, op, $3);
    gen_goto_blank(list);
    
} | calc_expression EQ calc_expression {
    $$.truelist = new_instrlist(nextinstr(list));
    $$.falselist = new_instrlist(nextinstr(list)+1);
    char op[1]={"="};
    gen_if(list, $1, op, $3);
    gen_goto_blank(list);
    
};

//一些辅助符号

M   :   { $$.instr = nextinstr(list); }
        ;

N   :   {
            $$.nextlist = new_instrlist(nextinstr(list));
                    gen_goto_blank(list);
        }
                ;
// --------------------------------------------------------------------------


// 没用的旧东西
// 声明 是总的语句的判别，每一句都是statment
// statement: SEMI    {}
//         |calc_expression ASSIGN calc_expression SEMI    { printf("(:=,%d, - , %d)",$3,$1);} //赋值语句 

// expression: 表达式，表达式可以为单个整数, 或 表达式+运算符+表达式
        /* $$ 表示该条规则所返回的语义值 */
        /* $1 $2 $3 ... 依次表示匹配到的 token 所具有的值 */
// ------BUG------
// calc_expression: INTEGER {printf("integer");} //integer
//     | calc_expression ADD calc_expression   {printf("(+ , %d , %d , T1)", $1, $3);} //加法
//     | calc_expression SUB calc_expression   {printf("(- , %d , %d , T1)", $1, $3);} //减法
//     | calc_expression MUL calc_expression   {printf("(* , %d , %d , T1)", $1, $3);} //乘法 
//     | calc_expression DIV calc_expression   {printf("(/ , %d , %d , T1)", $1, $3);} //除法
//     | calc_expression RT  calc_expression   {printf("(j> , %d , %d , step)",$1,$3);} //大于号
//     | calc_expression LT  calc_expression   {printf("(j< , %d , %d , step)",$1,$3);} //小于号
//     | calc_expression RE  calc_expression   {printf("(j>= , %d , %d , step)",$1,$3);} //大于等于号 
//     | calc_expression LE  calc_expression   {printf("(j<= , %d , %d , step)",$1,$3);} //小于等于号   
// backup        
// calc_expression: INTEGER { // 表达式可以为单个整数, 或 表达式+运算符+表达式
//         /* $$ 表示该条规则所返回的语义值 */
//         /* $1 $2 $3 ... 依次表示匹配到的 token 所具有的值 */
//         puts("---> found rule 1: calc_expression -> INTEGER");
//         $$ = $1;
//         printf("---> %d\n", $1);
//     }| calc_expression ADD calc_expression {
//         puts("---> found rule 2: calc_expression -> calc_expression ADD calc_expression");
//         $$ = $1 + $3;
//         printf("---> %d + %d = %d\n", $1, $3, $$);
//     }| calc_expression SUB calc_expression {
//         puts("---> found rule 3: calc_expression -> calc_expression SUB calc_expression");
//         $$ = $1 - $3;
//         printf("---> %d - %d = %d\n", $1, $3, $$);
//     }| calc_expression MUL calc_expression {
//         puts("---> found rule 4: calc_expression -> calc_expression MUL calc_expression");
//         $$ = $1 * $3;
//         printf("---> %d * %d = %d\n", $1, $3, $$);
//     }| calc_expression DIV calc_expression {
//         puts("---> found rule 5: calc_expression -> calc_expression DIV calc_expression");
//         $$ = $1 / $3; // don't care div 0
//         printf("---> %d / %d = %d\n", $1, $3, $$);
//     };
// --------------------------------------------------------------------------
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
    extern FILE *yyin;
    list = newcodelist();

    freopen("test_program.txt", "rt+", stdin);
    
    yyparse();
    print(list);
    fclose(stdin);
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

