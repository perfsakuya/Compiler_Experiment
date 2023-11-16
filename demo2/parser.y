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
}

/* 指明不同 token 或者 规则 的数据类型 */
%type <num> INTEGER exp


/* 根据规定，YACC仅对第一条规则感兴趣, 或者使用 %start 符号指定的起始规则 */
%start program


%%

program: line | line program;
line: exp LF {
        printf("ans: %d\n", $1);
    };
exp: INTEGER { // 表达式可以为单个整数, 或 表达式+运算符+表达式
        /* $$ 表示该条规则所返回的语义值 */
        /* $1 $2 $3 ... 依次表示匹配到的 token 所具有的值 */
        puts("---> found rule 1: exp -> INTEGER");
        $$ = $1;
        printf("---> %d\n", $1);
    }| exp ADD exp {
        puts("---> found rule 2: exp -> exp ADD exp");
        $$ = $1 + $3;
        printf("---> %d + %d = %d\n", $1, $3, $$);
    }| exp SUB exp {
        puts("---> found rule 3: exp -> exp SUB exp");
        $$ = $1 - $3;
        printf("---> %d - %d = %d\n", $1, $3, $$);
    }| exp MUL exp {
        puts("---> found rule 4: exp -> exp MUL exp");
        $$ = $1 * $3;
        printf("---> %d * %d = %d\n", $1, $3, $$);
    }| exp DIV exp {
        puts("---> found rule 5: exp -> exp DIV exp");
        $$ = $1 / $3; // don't care div 0
        printf("---> %d / %d = %d\n", $1, $3, $$);
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
