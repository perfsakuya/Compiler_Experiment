%{
/* 包含所需头文件 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tiny.h"
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
    int *boolvalue; // 0==false, 1==true
}

/* 指明不同 token 或者 规则 的数据类型 */
%type <num> INTEGER assignment_list meta_assignment 
%type <str> program_name id variable_list exp 

/* 根据规定，YACC仅对第一条规则感兴趣, 或者使用 %start 符号指定的起始规则 */
%start program

%%

// 递归方法在这里实现，便于查看
// 规则：program识别一次，var统一在begin前识别，begin之后识别main(statement)，main(statement)之后识别end.
// 1.识别别开头声明 PROGRAM id;
program: start | start program ; 
// 2.识别变量声明 var a,b,c:integer;
start: start declaration ; 
 // 3.识别begin标识符
declaration: declaration begin ;
// 4.识别主函数
begin: begin statement ; 
// 5. 识别end.
statement: statement end ; 


// 具体实现
// 1.识别开头声明 PROGRAM id;
start: PROGRAM program_name SEMI LF {
    printf("(%d) (program,%s,-,-)\n", quad_ruple_count, $2);
    quad_ruple_count++;
}
program_name: id {
    $$ = $1;
}
// 2.变量常量声明
declaration: VAR variable_list COLON INT SEMI LF {
    printf("[info] Variable Declaration: %s of type integer.\n", $2); // 只作提示，以后要删除
} | LF {
    // do nothing
}
variable_list: id {
    $$ = $1;
} | variable_list COMMA id {
    $$ = strcat($1, ",");
    $$ = strcat($1, $3);
}
// 3.begin开始符号
begin: BEG LF {
    printf("[info] Beginning main part.\n"); // 只作提示，以后要删除
}


// 4.主程序(语句块)
// <语句> → <赋值句>│<if句>│<while句>│<repeat句>│<复合句>
statement: assignment_list {
    printf("[info] Processing assignment.\n"); // 只作提示，以后要删除
} | if_statement {

} | while_statement {

} | repeat_statement {

};

// 4.1 <赋值句> → <标识符> := <算术表达式>
assignment_list: meta_assignment LF {
    $$ = $1;
} | meta_assignment assignment_list{
    $$ = $1;
};
meta_assignment: id ASSIGNMENT exp SEMI {
    // 输出赋值的四元式
    printf("(%d) (:=, %s , - , %s)\n",quad_ruple_count, $3, $1);
    quad_ruple_count++;
    // 这里储存变量的值（后续如果有需要的话）（作业中不用实现）
};
// 算数表达式（部分）
exp: INTEGER {
    char temp[20];
    snprintf(temp, sizeof(temp), "%d", $1); // 转换成str再传参
    $$ = temp; 
} | id {
    $$ = $1; // 本身就是str，直接传值
} | exp ADD exp {
    tmp_count++;
    char* T;
    asprintf(&T, "T%d", tmp_count);
    printf("(%d) (+, %s, %s, %s)\n",quad_ruple_count,$1,$3,T);
    quad_ruple_count++;
    $$ = T;// 修改后的传值
} | exp SUB exp {
    tmp_count++;
    char* T;
    asprintf(&T, "T%d", tmp_count);
    printf("(%d) (-, %s, %s, %s)\n",quad_ruple_count,$1,$3,T);
    quad_ruple_count++;
    $$ = T;// 修改后的传值
} | exp MUL exp {
    tmp_count++;
    char* T;
    asprintf(&T, "T%d", tmp_count);
    printf("(%d) (*, %s, %s, %s)\n",quad_ruple_count,$1,$3,T);
    quad_ruple_count++;
    $$ = T;// 修改后的传值
} | exp DIV exp {
    tmp_count++;
    char* T;
    asprintf(&T, "T%d", tmp_count);
    printf("(%d) (/, %s, %s, %s)\n",quad_ruple_count,$1,$3,T);
    quad_ruple_count++;
    $$ = T;// 修改后的传值
};

// 4.2 布尔表达式
// <布尔表达式> → <布尔表达式> or <布尔项>│<布尔项>

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
// <布尔量> → <布尔常量>│<标识符>│（ <布尔表达式> ）│ 
bool_3: bool_value {

} | id {

} | LB bool_expression RB {

} | bool_comparison { // <标识符> <关系符> <标识符>│<算术表达式> <关系符> <算术表达式>

};


// <标识符> <关系符> <标识符>
// 需要检查
bool_comparison: exp LT exp {
    printf("(%d) (j<, %s, %s, %s)\n",quad_ruple_count,$1,$3,quad_ruple_count+2);
    quad_ruple_count++;
} | exp LE exp {
    printf("(%d) (j<=, %s, %s, %s)\n",quad_ruple_count,$1,$3,quad_ruple_count+2);
    quad_ruple_count++;
} | exp RT exp {
} | exp RT exp {
    printf("(%d) (j>, %s, %s, %s)\n",quad_ruple_count,$1,$3,quad_ruple_count+2);
    quad_ruple_count++;
} | exp RE exp {
} | exp RE exp {
    printf("(%d) (j>=, %s, %s, %s)\n",quad_ruple_count,$1,$3,quad_ruple_count+2);
    quad_ruple_count++;
} | exp EQ exp {
    printf("(%d) (j=, %s, %s, %s)\n",quad_ruple_count,$1,$3,quad_ruple_count+2);
    quad_ruple_count++;
}

// ------------------------Unfinished!!!---------------------------
// 我们要用tiny.h中的backpatch和merge进行操作，从而达到状态转移的效果
// 4.3 <while句> → while <布尔表达式> do <语句>
while_statement: WHILE bool_comparison DO statement {
    backpatch
>>>>>>> 4dc1b967ef5b26db89d1c5343c8ddcbfa2fb0d47
    printf("(%d) (j,-,-,%s )\n",quad_ruple_count,);
    quad_ruple_count++;
}   |IF comparison THEN statement ELSE statement {      //4.4 If 语句
    printf("(%d) (j,-,-,%s )\n",quad_ruple_count,);
    quad_ruple_count++;
}   | meta_assignment


// 4.4 <if句>→ if <布尔表达式> then <语句>│if <布尔表达式> then <语句> else <语句>
if_statement: IF bool_comparison THEN statement {
    printf("(%d) (j,-,-,%s )\n",quad_ruple_count,);
    quad_ruple_count++;
} | IF bool_comparison THEN statement ELSE statement {

};

// 4.5 <repeat句> → repeat <语句> until <布尔表达式>
repeat_statement: REPEAT statement UNTIL bool_comparison {

};

// --------------------end Unfinished!!-----------------------------



// 5.end结束符号
end: END DOT LF {
    printf("(%d) (sys , - , - , - )\n", quad_ruple_count);
    printf("[info] Ending main part.\n"); // 只作提示，以后要删除
    YYACCEPT;
};






// 没用的旧东西
// 声明 是总的语句的判别，每一句都是statment
// statement: SEMI    {}
//         |exp ASSIGNMENT exp SEMI    { printf("(:=,%d, - , %d)",$3,$1);} //赋值语句 

// expression: 表达式，表达式可以为单个整数, 或 表达式+运算符+表达式
        /* $$ 表示该条规则所返回的语义值 */
        /* $1 $2 $3 ... 依次表示匹配到的 token 所具有的值 */
// ------BUG------
// exp: INTEGER {printf("integer");} //integer
//     | exp ADD exp   {printf("(+ , %d , %d , T1)", $1, $3);} //加法
//     | exp SUB exp   {printf("(- , %d , %d , T1)", $1, $3);} //减法
//     | exp MUL exp   {printf("(* , %d , %d , T1)", $1, $3);} //乘法 
//     | exp DIV exp   {printf("(/ , %d , %d , T1)", $1, $3);} //除法
//     | exp RT  exp   {printf("(j> , %d , %d , step)",$1,$3);} //大于号
//     | exp LT  exp   {printf("(j< , %d , %d , step)",$1,$3);} //小于号
//     | exp RE  exp   {printf("(j>= , %d , %d , step)",$1,$3);} //大于等于号 
//     | exp LE  exp   {printf("(j<= , %d , %d , step)",$1,$3);} //小于等于号   
// backup        
// exp: INTEGER { // 表达式可以为单个整数, 或 表达式+运算符+表达式
//         /* $$ 表示该条规则所返回的语义值 */
//         /* $1 $2 $3 ... 依次表示匹配到的 token 所具有的值 */
//         puts("---> found rule 1: exp -> INTEGER");
//         $$ = $1;
//         printf("---> %d\n", $1);
//     }| exp ADD exp {
//         puts("---> found rule 2: exp -> exp ADD exp");
//         $$ = $1 + $3;
//         printf("---> %d + %d = %d\n", $1, $3, $$);
//     }| exp SUB exp {
//         puts("---> found rule 3: exp -> exp SUB exp");
//         $$ = $1 - $3;
//         printf("---> %d - %d = %d\n", $1, $3, $$);
//     }| exp MUL exp {
//         puts("---> found rule 4: exp -> exp MUL exp");
//         $$ = $1 * $3;
//         printf("---> %d * %d = %d\n", $1, $3, $$);
//     }| exp DIV exp {
//         puts("---> found rule 5: exp -> exp DIV exp");
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

