%{
#include <stdio.h>
#include "y.tab.h" // 由 yacc -d 生成
%}
digit       [0-9]
 // <整数> → <数字>│<整数> <数字>
integer    {digit}+
%%
[ \t]+       ; // 空白字符
[\n]         return LF; // 换行符
 /* 整数 */
{integer}    yylval.num = atoi(yytext); return INTEGER;
 /* 符号 */
"+"          return ADD;
"-"          return SUB;
"*"          return MUL;
"/"          return DIV;
%%
