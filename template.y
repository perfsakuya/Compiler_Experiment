%{
/* 包含所需头文件 */
#include <stdio.h>
#include <string.h>
%}


/* 声明 token 供后续使用, 同时也可以在 lex 中使用 */
%token INTEGER
%token LF

/* %left 表示左结合, %right 表示右结合 */

/* 最后列出的定义具有最高的优先级 */
%left ADD SUB
%left MUL DIV

/* 定义结构体, 使得 token 可以附带相应的数据信息(语义值) */



/* 指明不同 token 或者 规则 的数据类型 */
%type <num> INTEGER exp
/* 根据规定,YACC仅对第一条规则感兴趣, 或者使用 %start 符号指定的起始规则 */


%start program

%%
program: line | line program;
line: exp LF {
        printf("ans: %d\n", $1);
    };


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
