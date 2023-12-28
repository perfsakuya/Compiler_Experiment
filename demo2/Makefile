CC=gcc
LEX=flex
YACC=bison
RM=del

all: calc.exe

calc.exe: lex.yy.c y.tab.c y.tab.h
	$(CC) lex.yy.c y.tab.c -o calc

lex.yy.c: scanner.l
	$(LEX) scanner.l

y.tab.c: parser.y
	$(YACC) -y parser.y

y.tab.h: parser.y
	$(YACC) -y -d parser.y

clean:
	$(RM) calc.exe lex.yy.c y.tab.c y.tab.h
