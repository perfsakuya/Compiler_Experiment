%{
#include <stdio.h>
%}
letter      [A-Za-z]
digit       [0-9]

 // <标识符> → <字母>│<标识符> <数字>│<标识符> <字母>
identifier {letter}({letter}|{digit})*
%%
[ \t\r\a]+     ; // 空白字符
[\n]           ; // 换行符
program      return 23;
var          return 33;
{identifier} return 36; // 标识符
","          return 44;
":"          return 50;
";"          return 52;
 /* write you code here */

%%
int main(int argc, char const *argv[]) {
    int type;

    while (type = yylex()) {
        printf("(%d, '%s')\n", type, yytext);
    }

    return 0;
}

int yywrap() {
    return 1;
}
