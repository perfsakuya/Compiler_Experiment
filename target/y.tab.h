/* A Bison parser, made by GNU Bison 3.4.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2019 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    LF = 258,
    AND = 259,
    ARR = 260,
    BEG = 261,
    BOOL = 262,
    CALL = 263,
    CASE = 264,
    CHR = 265,
    CONST = 266,
    DIM = 267,
    DO = 268,
    ELSE = 269,
    END = 270,
    BOOLFALSE = 271,
    FOR = 272,
    IF = 273,
    INPUT = 274,
    INT = 275,
    NOT = 276,
    OF = 277,
    OR = 278,
    OUTPUT = 279,
    PROCEDURE = 280,
    PROGRAM = 281,
    READ = 282,
    REAL = 283,
    REPEAT = 284,
    SET = 285,
    STOP = 286,
    THEN = 287,
    TO = 288,
    BOOLTRUE = 289,
    UNTIL = 290,
    VAR = 291,
    WHILE = 292,
    WRITE = 293,
    LB = 294,
    RB = 295,
    RCOMMENT = 296,
    LCOMMENT = 297,
    COMMA = 298,
    DOT = 299,
    TDOT = 300,
    COLON = 301,
    ASSIGN = 302,
    SEMI = 303,
    LT = 304,
    LE = 305,
    NE = 306,
    EQ = 307,
    RT = 308,
    RE = 309,
    LC = 310,
    RC = 311,
    INTEGER = 312,
    id = 313,
    TRUECHAR = 314,
    FALSECHAR = 315,
    TRUECOMMENT = 316,
    FALSECOMMENT = 317,
    ILLEGALCHR = 318,
    ADD = 319,
    SUB = 320,
    MUL = 321,
    DIV = 322,
    WITHOUT_ELSE = 323
  };
#endif
/* Tokens.  */
#define LF 258
#define AND 259
#define ARR 260
#define BEG 261
#define BOOL 262
#define CALL 263
#define CASE 264
#define CHR 265
#define CONST 266
#define DIM 267
#define DO 268
#define ELSE 269
#define END 270
#define BOOLFALSE 271
#define FOR 272
#define IF 273
#define INPUT 274
#define INT 275
#define NOT 276
#define OF 277
#define OR 278
#define OUTPUT 279
#define PROCEDURE 280
#define PROGRAM 281
#define READ 282
#define REAL 283
#define REPEAT 284
#define SET 285
#define STOP 286
#define THEN 287
#define TO 288
#define BOOLTRUE 289
#define UNTIL 290
#define VAR 291
#define WHILE 292
#define WRITE 293
#define LB 294
#define RB 295
#define RCOMMENT 296
#define LCOMMENT 297
#define COMMA 298
#define DOT 299
#define TDOT 300
#define COLON 301
#define ASSIGN 302
#define SEMI 303
#define LT 304
#define LE 305
#define NE 306
#define EQ 307
#define RT 308
#define RE 309
#define LC 310
#define RC 311
#define INTEGER 312
#define id 313
#define TRUECHAR 314
#define FALSECHAR 315
#define TRUECOMMENT 316
#define FALSECOMMENT 317
#define ILLEGALCHR 318
#define ADD 319
#define SUB 320
#define MUL 321
#define DIV 322
#define WITHOUT_ELSE 323

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
