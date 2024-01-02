%{
    #include "tiny.h"
    #define YYSTYPE node
    #include "y.tab.h"
    
    int yyerror();
    int yyerror(char* msg);
    extern int yylex();    
    codelist* list;
%}

%token IF ELSE THEN
%token WHILE DO
%token RELOP
%token NUMBER ID
%token AND
%left AND
%left '+' '-'
%left '*' '/'
%right '='
%right ASSIGN

%%
S   :   IF E THEN M S   
        {   
            backpatch(list, $3.truelist, $$.instr); 
            $$.nextlist = merge($2.falselist, $5.nextlist); 
        }

        |IF E THEN M S ELSE N M S   
        {   
            backpatch(list, $2.truelist, $4.instr);    
            backpatch(list, $2.falselist, $8.instr);
                    $5.nextlist = merge($5.nextlist, $7.nextlist);    
                    $$.nextlist = merge($5.nextlist, $9.nextlist); 
                } 
                  
        |WHILE M E DO M S
        {   
            backpatch(list, $6.nextlist, $2.instr);    
            backpatch(list, $3.truelist, $5.instr);
                    $$.nextlist = $3.falselist; 
                    gen_goto(list, $2.instr); 
                }
        
        
        |OP ASSIGN E
        {
            copyaddr(&$1, $1.lexeme); 
            gen_assignment(list, $1, $3);
        }
        
        |L
        {
            $$.nextlist = $1.nextlist;
        }
        |   {}
        ;
        
L   :   L ';' M S
        {
            backpatch(list, $1.nextlist, $3.instr);
            $$.nextlist = $4.nextlist;
        }
        |S
        {
            $$.nextlist = $1.nextlist;
        }
        ;

E   :   E AND M E    
        {   
            backpatch(list, $1.truelist, $3.instr);
            $$.truelist = $4.truelist; 
            $$.falselist = merge($1.falselist, $4.falselist); 
        }
        
        |OP RELOP OP
        {   
            $$.truelist = new_instrlist(nextinstr(list));
                        $$.falselist = new_instrlist(nextinstr(list)+1);
                        gen_if(list, $1, $2.oper, $3);
                        gen_goto_blank(list); 
                }
                
        |OP
        {
            copyaddr_fromnode(&$$, $1);
                }
        ;

OP  :   OP '+' OP { new_temp(&$$, get_temp_index(list)); gen_3addr(list, $$, $1, "+", $3); }
        | OP '-' OP { new_temp(&$$, get_temp_index(list)); gen_3addr(list, $$, $1, "-", $3); }
        | OP '*' OP { new_temp(&$$, get_temp_index(list)); gen_3addr(list, $$, $1, "*", $3); }
        | OP '/' OP { new_temp(&$$, get_temp_index(list)); gen_3addr(list, $$, $1, "/", $3); }
        |NUMBER {copyaddr(&$$, $1.lexeme);}
        |ID {copyaddr(&$$, $1.lexeme);}

M   :   { $$.instr = nextinstr(list); }
        ;

N   :   {
            $$.nextlist = new_instrlist(nextinstr(list));
                    gen_goto_blank(list);
        }
                ;
                
%%

// int yyerror(char* msg)
// {
//     printf("\nERROR with message: %s\n", msg);
//     return 0;
// }


int main()
{
    list = newcodelist();

    freopen("test.in", "rt+", stdin);
    freopen("test.out", "wt+", stdout);

    yyparse();
    print(list);
    
    fclose(stdin);

    fclose(stdout);
    return 0;
}