%{
	#include "y.tab.h"
%}
delim	[ \t\n\r]
ws	[delim]+
letter	[A-za-z]
digit        [0-9]
id        {letter}({letter}|{digit})*
number        {digit}+

%%
if	{ return( IF ); }
else	{ return( ELSE ); }
then	{ return( THEN ); }
while	{ return( WHILE ); }
do	{ return( DO ); }
and	{return( AND ); }
"+"    { return( '+' ); }
"-"    { return( '-' ); }
"*"    { return( '*' ); }
"/"    { return( '/' ); }
":="    { filloperator(&yylval, yytext); return( ASSIGN ); }
"<"|"<="|">"|">="|"!="|"="    { filloperator(&yylval, yytext); return( RELOP ); }
";"    { return( ';' ); }
{ws}    { }
{id}    { filllexeme(&yylval, yytext);  return( ID ); }
{number}    { filllexeme(&yylval, yytext); return( NUMBER ); }
%%

int yywrap() 
{ 
   return (1); 
} 
