%{
/* ???????????? */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "try.h"
#define YYSTYPE node
codelist* list;

char* prog_name;
// int quad_ruple_count = 0; // ???????
extern int yylineno;
extern char* yytext;
extern int yylex();    
// int yyerror();
// int yyerror(char* msg);
%}

/* ???? token ?????????, ????????? lex ????? */
%token AND ARR BEG BOOL CALL CASE CHR CONST DIM DO ELSE END BOOLFALSE FOR IF INPUT INT NOT OF OR OUTPUT PROCEDURE PROGRAM READ REAL REPEAT SET STOP THEN TO BOOLTRUE UNTIL VAR WHILE WRITE RELOP
%token LB RB RCOMMENT LCOMMENT COMMA DOT TDOT COLON ASSIGN SEMI LT LE NE EQ RT RE LC RC
%token INTEGER id TRUECHAR FALSECHAR TRUECOMMENT FALSECOMMENT ILLEGALCHR

/* %left ???????, %right ??????? */
/* ????г?????????????????? */
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


/* ???????, ??? token ???????????????????(?????) */
// ????????
// %union {
//     int num;
//     char *str;
//     int boolvalue; // 0==false, 1==true
// }

/* ?????? token ???? ???? ?????????? */
// %type <num> INTEGER assignment_statement meta_assignment 
// %type <str> program_name id variable_list calc_expression var_definition 
// %type <boolvalue> bool_expression
/* ????涨??YACC????????????????, ??????? %start ???????????????? */
%start program

%%

// ---------------------------1 ??????--------------------------------------
// 1.1 <????> ?? program <?????> ; | program
program:    PROGRAM program_name SEMI program
        
            | VAR var_definition program
            {
                printf("[info] Variable Declaration: of type integer.\n"); // ???????????????
            }
            | BEG statement
            {
                printf("[info] BEGIN\n"); // ???????????????
            }
            ;

program_name: id {
    prog_name = $1.lexeme;
    // printf("(%d) (program,%s,-,-)\n", quad_ruple_count, $1.lexeme);
};
var_definition : id COMMA var_definition
                | id COLON INT SEMI var_definition
                {
                    // printf("[info] FINISH VAR\n"); // ???????????????
                }
                | {}
                ;
// --------------------------------------------------------------------------


// ---------------------------2 ?????--------------------------------------
// <???> ?? <?????>??<if??>??<while??>??<repeat??>??<?????>
statement : IF expression THEN M statement 
            {
                backpatch(list, $3.truelist, $$.instr);
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
            printf("[info] FINISH PROGRAM\n"); // 只作提示，以后要删除
            YYACCEPT; // 结束
        }
        |statement
        {
            $$.nextlist = $1.nextlist;
        }
        ;
// ???expression??? ??????? AND OR NOT RELOP ??calc_expression

// RELOP ????????
// "<"|"<="|">"|">="|"!="|"="    { filloperator(&yylval, yytext); return( RELOP ); }
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
// ?Щ????????

calc_expression :   INTEGER 
                {
                    copyaddr(&$$, $1.lexeme);
                }

                |calc_expression ADD calc_expression 
                {
                    new_temp(&$$, get_temp_index(list));
                    gen_3addr(list, $$, $1, "+", $3);
                }

                |calc_expression SUB calc_expression 
                {
                    new_temp(&$$, get_temp_index(list));
                    gen_3addr(list, $$, $1, "-", $3);
                }
                |calc_expression MUL calc_expression 
                {
                    new_temp(&$$, get_temp_index(list)); 
                    gen_3addr(list, $$, $1, "*", $3);
                }

                |calc_expression DIV calc_expression 
                {
                    new_temp(&$$, get_temp_index(list)); 
                    gen_3addr(list, $$, $1, "/", $3);
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

int main() {
    // ???cool?????
    printf("\033[35m   _____ ______  _______  __    ______     ___    _   _____    ____  _______   __________ \n");
    printf("  / ___//  _/  |/  / __ \\/ /   / ____/    /   |  / | / /   |  / /\\ \\/ /__  /  / ____/ __ \\ \n");
    printf("  \\__ \\ / // /|_/ / /_/ / /   / __/      / /| | /  |/ / /| | / /  \\  /  / /  / __/ / /_/ /\n");
    printf(" ___/ // // /  / / ____/ /___/ /___     / ___ |/ /|  / ___ |/ /___/ /  / /__/ /___/ _, _/ \n");
    printf("/____/___/_/  /_/_/   /_____/_____/    /_/  |_/_/ |_/_/  |_/_____/_/  /____/_____/_/ |_|  v0.1.0\n");
    printf("------------------------------------------------------------------------------------------------\033[0m\n");
    printf("??????????????????????????????????????????????????\n");
    printf("??ANALYZER MADE BY:      ??\n");
    printf("????????     202230444429??\n");
    printf("??????     202230441183??\n");
    printf("???????     202230140314??\n");
    printf("??????????????????????????????????????????????????\n");
    printf("Text your program name here:\n");
    list = newcodelist();

    // ????????????????cmd???????????????????????????
    // freopen("test_program.txt", "rt+", stdin);
    // freopen("test_out.txt", "wt+", stdout);

    extern FILE *yyin;
    yyin = stdin;
    yyparse();
    print(list, prog_name);

    fclose(stdin);
    fclose(stdout);
    return 0;
}

// Linux ?????????????
int yyerror(char *msg) {
    fprintf(stderr, "[%s] encountered at line %d.\nUnexpected character: %s\n",msg, yylineno, removeNewline(yytext)); // ??????????????????????token
    return 0;
}
// Linux ?????????????
int yywrap(){
    return 1;
}