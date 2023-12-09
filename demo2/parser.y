%{
/* 包含所需头文件 */
#include <stdio.h>
#include <string.h>
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
%type <str> program_name id
%type <num> INTEGER exp
%type <str> variable_list

/* 根据规定，YACC仅对第一条规则感兴趣, 或者使用 %start 符号指定的起始规则 */
%start program

%%

// 递归方法在这里实现，便于查看
// 规则：program识别一次，var统一在begin前识别，begin之后识别main，main之后识别end.
// 1.识别别开头声明 PROGRAM id;
program: start | start program ; 
// 2.识别变量声明 var a,b,c:integer;
start: start declaration ; 
 // 3.识别begin标识符
declaration: declaration begin ;
// 4.识别主函数
begin: begin main ; 
// 5. 识别end.
main: main end ; 


// 具体实现
// 第一部分：识别开头声明 PROGRAM id;
start: PROGRAM program_name SEMI LF {
    printf("(program,%s,-,-)\n", $2);
}
program_name: id {
    $$ = $1;
}

// 第二部分：变量常量声明
declaration: VAR variable_list COLON INT SEMI LF {
    printf("Variable Declaration: %s of type integer.\n", $2); // 只作提示，以后要删除
}
variable_list: id {
    $$ = $1;
} | variable_list COMMA id {
    $$ = strcat($1, ",");
    $$ = strcat($1, $3);
}

// 第三部分：begin开始符号
begin: BEG LF {
    printf("beginning main part.\n"); // 只作提示，以后要删除
}

// 第四部分：主程序
main: OR LF{

    printf("main part.\n"); // 只作提示，以后要删除


}

// 第五部分：end结束符号
end: END DOT LF {
    printf("(sys , - , - , - )\n");
    printf("ending main part.\n"); // 只作提示，以后要删除
    YYACCEPT;
};






statement: 

// 声明 是总的语句的判别，每一句都是statment
// statement: SEMI    {}
//         |exp ASSIGNMENT exp SEMI    { printf("(:=,%d, - , %d)",$3,$1);} //赋值语句 

// expression: 表达式，表达式可以为单个整数, 或 表达式+运算符+表达式
        /* $$ 表示该条规则所返回的语义值 */
        /* $1 $2 $3 ... 依次表示匹配到的 token 所具有的值 */


// ------BUG------
exp: INTEGER {printf("integer");} //integer
    | exp ADD exp   {printf("(+ , %d , %d , T1)", $1, $3);} //加法
    | exp SUB exp   {printf("(- , %d , %d , T1)", $1, $3);} //减法
    | exp MUL exp   {printf("(* , %d , %d , T1)", $1, $3);} //乘法 
    | exp DIV exp   {printf("(/ , %d , %d , T1)", $1, $3);} //除法
    | exp RT  exp   {printf("(j> , %d , %d , step)",$1,$3);} //大于号
    | exp LT  exp   {printf("(j< , %d , %d , step)",$1,$3);} //小于号
    | exp RE  exp   {printf("(j>= , %d , %d , step)",$1,$3);} //大于等于号 
    | exp LE  exp   {printf("(j<= , %d , %d , step)",$1,$3);} //小于等于号   

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
    printf("Error encountered: %s \n", msg);
}
// Linux 下注释掉这个函数
int yywrap(){
    return 1;
}
