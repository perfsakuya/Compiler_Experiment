%{
/* 包含所需头文件 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tiny.h"
int quad_ruple_count = 0; // 地址计数
int tmp_count = 0;

%}

/* 声明 token 供后续使用, 同时也可以在 lex 中使用 */
%token LF AND ARR BEG BOOL CALL CASE CHR CONST DIM DO ELSE END BOOLFALSE FOR IF INPUT INT NOT OF OR OUTPUT PROCEDURE PROGRAM READ REAL REPEAT SET STOP THEN TO BOOLTRUE UNTIL VAR WHILE WRITE 
%token LB RB RCOMMENT LCOMMENT COMMA DOT TDOT COLON ASSIGNMENT SEMI LT LE NE EQ RT RE LC RC
%token INTEGER id TRUECHAR FALSECHAR TRUECOMMENT FALSECOMMENT ILLEGALCHR

/* %left 表示左结合, %right 表示右结合 */
/* 最后列出的定义具有最高的优先级 */
%left ADD SUB
%left MUL DIV 

/* 定义结构体, 使得 token 可以附带相应的数据信息(语义值) */
%union {
    int num;
    char *str;
    int boolvalue; // 0==false, 1==true
}

/* 指明不同 token 或者 规则 的数据类型 */
%type <num> INTEGER assignment_statement meta_assignment 
%type <str> program_name id variable_list calc_expression var_definition 
/* 根据规定，YACC仅对第一条规则感兴趣, 或者使用 %start 符号指定的起始规则 */
%start program

%%

// ---------------------------1 程序定义--------------------------------------
// 1.1 <程序> → program <标识符> ; | program
program: program | PROGRAM program_name SEMI LF {
    printf("(%d) (program,%s,-,-)\n", quad_ruple_count, $2);
    quad_ruple_count++;
} | program temp_rule;
program_name: id {
    $$ = $1;
};

// 1.1.5 <临时规则> → <变量说明> <复合句>
temp_rule: var_description complex_statement;

// 1.2 <变量说明> → var <变量定义>│ε
var_description: VAR var_definition LF {
    printf("[info] Variable Declaration: %s of type integer.\n", $2); // 只作提示，以后要删除
} | LF {
    // do nothing
};

// 1.3 <变量定义> → <标识符表> ：<类型> ;<变量定义>│<标识符表> ：<类型> ;
// 变量定义只能在一行进行
var_definition: variable_list COLON INT SEMI var_definition {
    $$ = $1;
} | variable_list COLON INT SEMI {
    $$ = $1;
};
// 1.4 <标识符表> → <标识符> ，<标识符表>│<标识符>
variable_list: id {
    $$ = $1;
} | id COMMA variable_list {
    $$ = strcat($1, ",");
    $$ = strcat($1, $3);
};
// --------------------------------------------------------------------------


// ---------------------------2 语句定义--------------------------------------
// 2.0 <语句> → <赋值句>│<if句>│<while句>│<repeat句>│<复合句>
statement: assignment_statement {
    printf("[info] Processing assignment.\n"); // 只作提示，以后要删除
} | if_statement {
    printf("[info] Processing if.\n"); // 只作提示，以后要删除
} | while_statement {
    printf("[info] Processing while.\n"); // 只作提示，以后要删除
} | repeat_statement {
    printf("[info] Processing while.\n"); // 只作提示，以后要删除
} | complex_statement {
    printf("[info] Processing complex.\n"); // 只作提示，以后要删除
};

// 2.1 <赋值句> → <标识符> := <算术表达式>
// assignment_statement: id ASSIGNMENT calc_expression {
//     printf("(%d) (:=, %s , - , %s)\n",quad_ruple_count, $3, $1);
//     quad_ruple_count++;
// };
assignment_statement: meta_assignment LF {
    $$ = $1;
} | meta_assignment assignment_statement{
    $$ = $1;
};
meta_assignment: id ASSIGNMENT calc_expression SEMI {
    // 输出赋值的四元式
    printf("(%d) (:=, %s , - , %s)\n",quad_ruple_count, $3, $1);
    quad_ruple_count++;
    // 这里储存变量的值（后续如果有需要的话）（作业中不用实现）
};



// <<<我们要用tiny.h中的backpatch和merge进行操作，从而达到状态转移的效果>>>

// 2.2 <if句>→ if <布尔表达式> then <语句>│if <布尔表达式> then <语句> else <语句>
if_statement: IF bool_comparison THEN statement {
    // printf("(%d) (j,-,-,%s )\n",quad_ruple_count,);
    // quad_ruple_count++;
} | IF bool_comparison THEN statement ELSE statement {

};

// 2.3 <while句> → while <布尔表达式> do <语句>
while_statement: WHILE bool_comparison DO statement {
    // backpatch
    // printf("(%d) (j,-,-,%s )\n",quad_ruple_count,);
    // quad_ruple_count++;
};

// 2.4 <repeat句> → repeat <语句> until <布尔表达式>
repeat_statement: REPEAT statement UNTIL bool_comparison {

};

// 2.5 <复合句> → begin <语句表> end
complex_statement: begin statement_list end {

};
// 2.5.a.begin开始符号
begin: BEG LF {
    printf("[info] Beginning main part.\n"); // 只作提示，以后要删除
};
// 2.5.b.end结束符号
end: END DOT LF {
    printf("(%d) (sys , - , - , - )\n", quad_ruple_count);
    printf("[info] Ending main part.\n"); // 只作提示，以后要删除
    YYACCEPT;
};

// 2.6 <语句表> → <语句> (;x)<语句表>│<语句>   <<<这里和文档中的不一样，中间不加分号>>>
statement_list: statement statement_list {

} | statement {

} | LF;
// --------------------------------------------------------------------------


// ---------------------------3 表达式定义------------------------------------
// 3.1 算术表达式
calc_expression: INTEGER {
    char temp[20];
    snprintf(temp, sizeof(temp), "%d", $1); // 转换成str再传参
    $$ = temp; 
} | id {
    $$ = $1; // 本身就是str，直接传值
} | calc_expression ADD calc_expression {
    tmp_count++;
    char* T;
    asprintf(&T, "T%d", tmp_count);
    printf("(%d) (+, %s, %s, %s)\n",quad_ruple_count,$1,$3,T);
    quad_ruple_count++;
    $$ = T;// 修改后的传值
} | calc_expression SUB calc_expression {
    tmp_count++;
    char* T;
    asprintf(&T, "T%d", tmp_count);
    printf("(%d) (-, %s, %s, %s)\n",quad_ruple_count,$1,$3,T);
    quad_ruple_count++;
    $$ = T;// 修改后的传值
} | calc_expression MUL calc_expression {
    tmp_count++;
    char* T;
    asprintf(&T, "T%d", tmp_count);
    printf("(%d) (*, %s, %s, %s)\n",quad_ruple_count,$1,$3,T);
    quad_ruple_count++;
    $$ = T;// 修改后的传值
} | calc_expression DIV calc_expression {
    tmp_count++;
    char* T;
    asprintf(&T, "T%d", tmp_count);
    printf("(%d) (/, %s, %s, %s)\n",quad_ruple_count,$1,$3,T);
    quad_ruple_count++;
    $$ = T;// 修改后的传值
};

// 3.2 <布尔表达式> → <布尔表达式> or <布尔项>│<布尔项>
bool_expression: bool_expression OR bool_1 {

} | bool_1 {

};
// <布尔项> → <布尔项> and <布因子>│<布因子>
bool_1: bool_1 AND bool_2 {

} | bool_2 {

};
// <布因子> → <布尔量>│not <布因子>
bool_2: bool_3 {

} | NOT bool_2 {

};
// <布尔量> → <布尔常量>(未使用)│<标识符>│（ <布尔表达式> ）│ ...↓...
bool_3: id {

} | LB bool_expression RB {

} | bool_comparison { // <标识符> <关系符> <标识符>│<算术表达式> <关系符> <算术表达式>

};
// bool_value: BOOLTRUE {
//     $$ = $1;
// }| BOOLFALSE {
//     $$ = $1;
// };

// 3.3 <布尔量> → <标识符> <关系符> <标识符>│<算术表达式> <关系符> <算术表达式>
// 需要检查
bool_comparison: calc_expression LT calc_expression {
    printf("(%d) (j<, %s, %s, %s)\n",quad_ruple_count,$1,$3,quad_ruple_count+2);
    quad_ruple_count++;
} | calc_expression LE calc_expression {
    printf("(%d) (j<=, %s, %s, %s)\n",quad_ruple_count,$1,$3,quad_ruple_count+2);
    quad_ruple_count++;
} | calc_expression RT calc_expression {
} | calc_expression RT calc_expression {
    printf("(%d) (j>, %s, %s, %s)\n",quad_ruple_count,$1,$3,quad_ruple_count+2);
    quad_ruple_count++;
} | calc_expression RE calc_expression {
} | calc_expression RE calc_expression {
    printf("(%d) (j>=, %s, %s, %s)\n",quad_ruple_count,$1,$3,quad_ruple_count+2);
    quad_ruple_count++;
} | calc_expression EQ calc_expression {
    printf("(%d) (j=, %s, %s, %s)\n",quad_ruple_count,$1,$3,quad_ruple_count+2);
    quad_ruple_count++;
};
// --------------------------------------------------------------------------


// 没用的旧东西
// 声明 是总的语句的判别，每一句都是statment
// statement: SEMI    {}
//         |calc_expression ASSIGNMENT calc_expression SEMI    { printf("(:=,%d, - , %d)",$3,$1);} //赋值语句 

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
%%




int main() {
    extern FILE *yyin;
    yyin = stdin;
    yyparse();
    return 0;
}
// Linux 下注释掉这个函数
void yyerror(char *msg) {
    printf("[Error] encountered: %s \n", msg);
}
// Linux 下注释掉这个函数
int yywrap(){
    return 1;
}

