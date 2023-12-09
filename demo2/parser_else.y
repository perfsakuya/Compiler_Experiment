%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
%}


%token LF AND ARR BEG BOOL CALL CASE CHR CONST DIM DO ELSE END BOOLFALSE FOR IF INPUT INT NOT OF OR OUTPUT PROCEDURE PROGRAM READ REAL REPEAT SET STOP THEN TO BOOLTRUE UNTIL VAR WHILE WRITE 
%token LB RB RCOMMENT LCOMMENT COMMA DOT TDOT COLON ASSIGNMENT SEMI LT LE NE EQ RT RE LC RC
%token INTEGER id TRUECHAR FALSECHAR TRUECOMMENT FALSECOMMENT ILLEGALCHR

// 定义结构体，包含可能的数据类型
%union {
    int num;       // 用于存储整数值
    char *str;     // 用于存储字符串值
}

// 声明可能的返回类型
%type <num> INTEGER
%type <str> id CHARCONST

%start expression

%%

expression: arithmetic_expression
          | boolean_expression
          | character_expression;

arithmetic_expression: arithmetic_expression PLUS term {
                        printf("Addition operation\n");
                    }
                  | arithmetic_expression MINUS term {
                        printf("Subtraction operation\n");
                    }
                  | term;

term: term TIMES factor {
        printf("Multiplication operation\n");
     }
    | term DIV factor {
        printf("Division operation\n");
     }
    | factor;

factor: arithmetic_value
      | MINUS factor {
            printf("Unary minus operation\n");
        };

arithmetic_value: INTEGER {
                    printf("Integer constant: %d\n", yylval.num);
                }
               | id {
                    printf("identifier: %s\n", yylval.str);
                }
               | LPAREN arithmetic_expression RPAREN {
                    printf("Parenthesized arithmetic expression\n");
                };

boolean_expression: boolean_expression OR boolean_term {
                        printf("Logical OR operation\n");
                    }
                 | boolean_term;

boolean_term: boolean_term AND boolean_factor {
                printf("Logical AND operation\n");
             }
           | boolean_factor;

boolean_factor: boolean_value
              | NOT boolean_factor {
                    printf("Logical NOT operation\n");
                };

boolean_value: BOOLFALSE {
                    printf("Boolean constant: 0\n");
                }
             | BOOLTRUE {
                    printf("Boolean constant: 1\n");
                }
             | id {
                    printf("identifier: %s\n", yylval.str);
                }
             | LPAREN boolean_expression RPAREN {
                    printf("Parenthesized boolean expression\n");
                }
             | id relational_operator id {
                    printf("Relational operation between identifiers\n");
                }
             | arithmetic_expression relational_operator arithmetic_expression {
                    printf("Relational operation between arithmetic expressions\n");
                };

relational_operator: LT {
                        printf("Less than\n");
                    }
                  | NE {
                        printf("Not equal\n");
                    }
                  | LE {
                        printf("Less than or equal\n");
                    }
                  | GE {
                        printf("Greater than or equal\n");
                    }
                  | GT {
                        printf("Greater than\n");
                    }
                  | EQ {
                        printf("Equal\n");
                    };

character_expression: CHARCONST {
                        printf("Character constant: %c\n", yylval.str[0]);
                    }
                  | id {
                        printf("identifier: %s\n", yylval.str);
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
    printf("[Error] encountered: %s \n", msg);
}
// Linux 下注释掉这个函数
int yywrap(){
    return 1;
}
