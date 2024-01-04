CC=gcc
LEX=flex
YACC=bison
RM=del

all: ANALYZER.exe

ANALYZER.exe: lex.yy.c y.tab.c y.tab.h
	$(CC) lex.yy.c y.tab.c -o ANALYZER

lex.yy.c: scanner.l
	$(LEX) scanner.l

y.tab.c: parser.y
	$(YACC) -y parser.y

y.tab.h: parser.y
	$(YACC) -y -d parser.y

clean:
	$(RM) ANALYZER.exe lex.yy.c y.tab.c y.tab.h
