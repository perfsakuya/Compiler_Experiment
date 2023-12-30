/* A Bison parser, made by GNU Bison 2.4.2.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C
   
      Copyright (C) 1984, 1989-1990, 2000-2006, 2009-2010 Free Software
   Foundation, Inc.
   
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

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.4.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Copy the first part of user declarations.  */

/* Line 189 of yacc.c  */
#line 1 "parser.y"

/* 包含所需头文件 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "try.h"
int quad_ruple_count = 0; // 地址计数
int tmp_count = 0;
extern int yylineno;
extern char* yytext;
codelist* list;


/* Line 189 of yacc.c  */
#line 86 "y.tab.c"

/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif


/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
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
     ASSIGNMENT = 302,
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
     SUB = 319,
     ADD = 320,
     DIV = 321,
     MUL = 322,
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
#define ASSIGNMENT 302
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
#define SUB 319
#define ADD 320
#define DIV 321
#define MUL 322
#define WITHOUT_ELSE 323




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
#endif


/* Copy the second part of user declarations.  */


/* Line 264 of yacc.c  */
#line 264 "y.tab.c"

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int yyi)
#else
static int
YYID (yyi)
    int yyi;
#endif
{
  return yyi;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)				\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack_alloc, Stack, yysize);			\
	Stack = &yyptr->Stack_alloc;					\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  5
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   90

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  69
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  24
/* YYNRULES -- Number of rules.  */
#define YYNRULES  48
/* YYNRULES -- Number of states.  */
#define YYNSTATES  101

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   323

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52,    53,    54,
      55,    56,    57,    58,    59,    60,    61,    62,    63,    64,
      65,    66,    67,    68
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint8 yyprhs[] =
{
       0,     0,     3,     8,    11,    13,    16,    20,    22,    28,
      33,    35,    39,    41,    43,    45,    47,    49,    53,    56,
      60,    64,    69,    70,    74,    80,    90,    97,   104,   106,
     108,   112,   116,   120,   124,   129,   131,   136,   138,   140,
     143,   147,   149,   153,   157,   161,   165,   169,   170
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      70,     0,    -1,    26,    71,    48,     3,    -1,    70,    72,
      -1,    58,    -1,    73,    77,    -1,    36,    74,     3,    -1,
       3,    -1,    75,    46,    20,    48,    74,    -1,    75,    46,
      20,    48,    -1,    58,    -1,    58,    43,    75,    -1,    81,
      -1,    82,    -1,    83,    -1,    84,    -1,    77,    -1,    78,
      80,    79,    -1,     6,     3,    -1,    15,    44,     3,    -1,
      76,    48,    80,    -1,    76,    48,     3,    80,    -1,    -1,
      58,    47,    85,    -1,    18,    90,    32,    91,    76,    -1,
      18,    90,    32,    91,    76,    14,    92,    91,    76,    -1,
      37,    91,    90,    13,    91,    76,    -1,    29,    91,    76,
      35,    86,    91,    -1,    57,    -1,    58,    -1,    85,    65,
      85,    -1,    85,    64,    85,    -1,    85,    67,    85,    -1,
      85,    66,    85,    -1,    87,    23,    91,    86,    -1,    87,
      -1,    87,     4,    91,    88,    -1,    88,    -1,    89,    -1,
      21,    88,    -1,    39,    86,    40,    -1,    90,    -1,    85,
      49,    85,    -1,    85,    50,    85,    -1,    85,    53,    85,
      -1,    85,    54,    85,    -1,    85,    52,    85,    -1,    -1,
      -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,    49,    49,    52,    53,    58,    61,    63,    69,    71,
      75,    77,    87,    89,    91,    93,    95,   100,   102,   106,
     113,   113,   113,   116,   141,   144,   152,   160,   170,   174,
     176,   180,   184,   188,   195,   199,   203,   207,   211,   213,
     219,   221,   231,   238,   245,   252,   259,   270,   273
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "LF", "AND", "ARR", "BEG", "BOOL",
  "CALL", "CASE", "CHR", "CONST", "DIM", "DO", "ELSE", "END", "BOOLFALSE",
  "FOR", "IF", "INPUT", "INT", "NOT", "OF", "OR", "OUTPUT", "PROCEDURE",
  "PROGRAM", "READ", "REAL", "REPEAT", "SET", "STOP", "THEN", "TO",
  "BOOLTRUE", "UNTIL", "VAR", "WHILE", "WRITE", "LB", "RB", "RCOMMENT",
  "LCOMMENT", "COMMA", "DOT", "TDOT", "COLON", "ASSIGNMENT", "SEMI", "LT",
  "LE", "NE", "EQ", "RT", "RE", "LC", "RC", "INTEGER", "id", "TRUECHAR",
  "FALSECHAR", "TRUECOMMENT", "FALSECOMMENT", "ILLEGALCHR", "SUB", "ADD",
  "DIV", "MUL", "WITHOUT_ELSE", "$accept", "program", "program_name",
  "temp_rule", "var_description", "var_definition", "variable_list",
  "statement", "complex_statement", "begin", "end", "statement_list",
  "assignment_statement", "if_statement", "while_statement",
  "repeat_statement", "calc_expression", "bool_expression", "bool_1",
  "bool_2", "bool_3", "bool_comparison", "M", "N", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306,   307,   308,   309,   310,   311,   312,   313,   314,
     315,   316,   317,   318,   319,   320,   321,   322,   323
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    69,    70,    70,    71,    72,    73,    73,    74,    74,
      75,    75,    76,    76,    76,    76,    76,    77,    78,    79,
      80,    80,    80,    81,    82,    82,    83,    84,    85,    85,
      85,    85,    85,    85,    86,    86,    87,    87,    88,    88,
      89,    89,    90,    90,    90,    90,    90,    91,    92
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     4,     2,     1,     2,     3,     1,     5,     4,
       1,     3,     1,     1,     1,     1,     1,     3,     2,     3,
       3,     4,     0,     3,     5,     9,     6,     6,     1,     1,
       3,     3,     3,     3,     4,     1,     4,     1,     1,     2,
       3,     1,     3,     3,     3,     3,     3,     0,     0
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       0,     0,     0,     4,     0,     1,     7,     0,     3,     0,
       0,    10,     0,     0,     0,     5,    22,     2,     0,     6,
       0,    18,     0,    47,    47,     0,     0,    16,     0,    12,
      13,    14,    15,    11,     0,    28,    29,     0,     0,     0,
       0,     0,    22,     0,    17,     9,     0,     0,     0,     0,
       0,     0,     0,     0,     0,    47,     0,     0,    23,    22,
      20,     0,     8,    42,    43,    46,    44,    45,    31,    30,
      33,    32,     0,     0,    47,    21,    19,    24,     0,     0,
      47,    35,    37,    38,    41,     0,    48,    39,     0,    27,
      47,    47,    26,    47,    40,     0,     0,     0,    36,    34,
      25
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     2,     4,     8,     9,    12,    13,    26,    27,    16,
      44,    28,    29,    30,    31,    32,    37,    80,    81,    82,
      83,    84,    39,    93
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -65
static const yytype_int8 yypact[] =
{
     -22,   -23,     7,   -65,   -37,   -65,   -65,   -20,   -65,    35,
      39,     1,    42,     2,    43,   -65,     0,   -65,   -20,   -65,
      29,   -65,   -44,   -65,   -65,     5,     3,   -65,    38,   -65,
     -65,   -65,   -65,   -65,     6,   -65,   -65,    11,    23,     0,
     -44,   -44,    -1,    18,   -65,   -20,   -44,   -44,   -44,   -44,
     -44,   -44,   -44,   -44,   -44,   -65,    36,    55,   -42,     0,
     -65,    67,   -65,   -42,   -42,   -42,   -42,   -42,   -47,   -47,
     -65,   -65,     0,   -18,   -65,   -65,   -65,    58,   -18,   -18,
     -65,     4,   -65,   -65,   -65,     0,   -65,   -65,    48,   -65,
     -65,   -65,   -65,   -65,   -65,   -18,   -18,     0,   -65,   -65,
     -65
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -65,   -65,   -65,   -65,   -65,    28,    71,   -38,    81,   -65,
     -65,   -33,   -65,   -65,   -65,   -65,    33,   -64,   -65,   -62,
     -65,   -10,   -24,   -65
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -1
static const yytype_uint8 yytable[] =
{
      40,    56,    59,    78,     1,    14,    14,     5,    90,    60,
       6,    10,    38,    35,    36,    88,    87,    22,    22,    53,
      54,    79,    51,    52,    53,    54,    75,    91,    23,    23,
      57,    72,    99,    98,    77,     3,    24,    24,    11,    35,
      36,    14,    17,     7,    18,    19,    21,    92,    20,    34,
      85,    42,    41,    43,    45,    55,    89,    25,    25,   100,
      46,    47,    61,    48,    49,    50,    95,    96,    74,    97,
      76,    73,    86,    62,    58,    51,    52,    53,    54,    63,
      64,    65,    66,    67,    68,    69,    70,    71,    94,    33,
      15
};

static const yytype_uint8 yycheck[] =
{
      24,    39,     3,    21,    26,     6,     6,     0,     4,    42,
       3,    48,    22,    57,    58,    79,    78,    18,    18,    66,
      67,    39,    64,    65,    66,    67,    59,    23,    29,    29,
      40,    55,    96,    95,    72,    58,    37,    37,    58,    57,
      58,     6,     3,    36,    43,     3,     3,    85,    46,    20,
      74,    48,    47,    15,    48,    32,    80,    58,    58,    97,
      49,    50,    44,    52,    53,    54,    90,    91,    13,    93,
       3,    35,    14,    45,    41,    64,    65,    66,    67,    46,
      47,    48,    49,    50,    51,    52,    53,    54,    40,    18,
       9
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    26,    70,    58,    71,     0,     3,    36,    72,    73,
      48,    58,    74,    75,     6,    77,    78,     3,    43,     3,
      46,     3,    18,    29,    37,    58,    76,    77,    80,    81,
      82,    83,    84,    75,    20,    57,    58,    85,    90,    91,
      91,    47,    48,    15,    79,    48,    49,    50,    52,    53,
      54,    64,    65,    66,    67,    32,    76,    90,    85,     3,
      80,    44,    74,    85,    85,    85,    85,    85,    85,    85,
      85,    85,    91,    35,    13,    80,     3,    76,    21,    39,
      86,    87,    88,    89,    90,    91,    14,    88,    86,    91,
       4,    23,    76,    92,    40,    91,    91,    91,    88,    86,
      76
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  However,
   YYFAIL appears to be in use.  Nevertheless, it is formally deprecated
   in Bison 2.4.2's NEWS entry, where a plan to phase it out is
   discussed.  */

#define YYFAIL		goto yyerrlab
#if defined YYFAIL
  /* This is here to suppress warnings from the GCC cpp's
     -Wunused-macros.  Normally we don't worry about that warning, but
     some users do, and we want to make it easy for users to remove
     YYFAIL uses, which will produce warnings from Bison 2.5.  */
#endif

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if defined YYLTYPE_IS_TRIVIAL && YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
#else
static void
yy_stack_print (yybottom, yytop)
    yytype_int16 *yybottom;
    yytype_int16 *yytop;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}

/* Prevent warnings from -Wmissing-prototypes.  */
#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */


/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*-------------------------.
| yyparse or yypush_parse.  |
`-------------------------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{


    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       `yyss': related to states.
       `yyvs': related to semantic values.

       Refer to the stacks thru separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yytoken = 0;
  yyss = yyssa;
  yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */
  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;

	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),
		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss_alloc, yyss);
	YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:

/* Line 1464 of yacc.c  */
#line 49 "parser.y"
    {
    printf("(%d) (program,%s,-,-)\n", quad_ruple_count, (yyvsp[(2) - (4)]));
    quad_ruple_count++;
}
    break;

  case 4:

/* Line 1464 of yacc.c  */
#line 53 "parser.y"
    {
    (yyval) = (yyvsp[(1) - (1)]);
}
    break;

  case 6:

/* Line 1464 of yacc.c  */
#line 61 "parser.y"
    {
    printf("[info] Variable Declaration: %s of type integer.\n", (yyvsp[(2) - (3)])); // 只作提示，以后要删除
}
    break;

  case 7:

/* Line 1464 of yacc.c  */
#line 63 "parser.y"
    {
    // do nothing
}
    break;

  case 8:

/* Line 1464 of yacc.c  */
#line 69 "parser.y"
    {
    (yyval) = (yyvsp[(1) - (5)]);
}
    break;

  case 9:

/* Line 1464 of yacc.c  */
#line 71 "parser.y"
    {
    (yyval) = (yyvsp[(1) - (4)]);
}
    break;

  case 10:

/* Line 1464 of yacc.c  */
#line 75 "parser.y"
    {
    (yyval) = (yyvsp[(1) - (1)]);
}
    break;

  case 11:

/* Line 1464 of yacc.c  */
#line 77 "parser.y"
    {
    (yyval) = strcat((yyvsp[(1) - (3)]), ",");
    (yyval) = strcat((yyvsp[(1) - (3)]), (yyvsp[(3) - (3)]));
}
    break;

  case 12:

/* Line 1464 of yacc.c  */
#line 87 "parser.y"
    {
    printf("[info] Processed assignment.\n"); // 只作提示，以后要删除
}
    break;

  case 13:

/* Line 1464 of yacc.c  */
#line 89 "parser.y"
    {
    printf("[info] Processed if.\n"); // 只作提示，以后要删除
}
    break;

  case 14:

/* Line 1464 of yacc.c  */
#line 91 "parser.y"
    {
    printf("[info] Processed while.\n"); // 只作提示，以后要删除
}
    break;

  case 15:

/* Line 1464 of yacc.c  */
#line 93 "parser.y"
    {
    printf("[info] Processed while.\n"); // 只作提示，以后要删除
}
    break;

  case 16:

/* Line 1464 of yacc.c  */
#line 95 "parser.y"
    {
    printf("[info] Processed complex.\n"); // 只作提示，以后要删除
}
    break;

  case 18:

/* Line 1464 of yacc.c  */
#line 102 "parser.y"
    {
    printf("[info] Beginning main part.\n"); // 只作提示，以后要删除
}
    break;

  case 19:

/* Line 1464 of yacc.c  */
#line 106 "parser.y"
    {
    printf("(%d) (sys , - , - , - )\n", quad_ruple_count);
    printf("[info] Ending main part.\n"); // 只作提示，以后要删除
    YYACCEPT;
}
    break;

  case 23:

/* Line 1464 of yacc.c  */
#line 116 "parser.y"
    {
    // 输出赋值的四元式
    copyaddr(&(yyvsp[(1) - (3)]), (yyvsp[(1) - (3)]).lexeme); 
    gen_assignment(list, (yyvsp[(1) - (3)]), (yyvsp[(3) - (3)]));
    // 这里储存变量的值（后续如果有需要的话）（作业中不用实现）
}
    break;

  case 24:

/* Line 1464 of yacc.c  */
#line 141 "parser.y"
    {  // 消除冲突
    backpatch(list, (yyvsp[(2) - (5)]).truelist, (yyvsp[(4) - (5)]).instr);
    (yyval).nextlist = (yyvsp[(5) - (5)]).nextlist;
}
    break;

  case 25:

/* Line 1464 of yacc.c  */
#line 144 "parser.y"
    { 
    backpatch(list, (yyvsp[(2) - (9)]).truelist, (yyvsp[(4) - (9)]).instr);    
    backpatch(list, (yyvsp[(2) - (9)]).falselist, (yyvsp[(8) - (9)]).instr);
    (yyvsp[(5) - (9)]).nextlist = merge((yyvsp[(5) - (9)]).nextlist, (yyvsp[(7) - (9)]).nextlist);    
    (yyval).nextlist = merge((yyvsp[(5) - (9)]).nextlist, (yyvsp[(9) - (9)]).nextlist);
}
    break;

  case 26:

/* Line 1464 of yacc.c  */
#line 152 "parser.y"
    {
    backpatch(list, (yyvsp[(6) - (6)]).nextlist, (yyvsp[(2) - (6)]).instr);    
    backpatch(list, (yyvsp[(3) - (6)]).truelist, (yyvsp[(5) - (6)]).instr);
    (yyval).nextlist = (yyvsp[(3) - (6)]).falselist; 
    gen_goto(list, (yyvsp[(2) - (6)]).instr);
}
    break;

  case 27:

/* Line 1464 of yacc.c  */
#line 160 "parser.y"
    {
    backpatch(list, (yyvsp[(5) - (6)]).falselist, (yyvsp[(2) - (6)]).instr);
    backpatch(list, (yyvsp[(5) - (6)]).truelist, (yyvsp[(6) - (6)])instr);
}
    break;

  case 28:

/* Line 1464 of yacc.c  */
#line 170 "parser.y"
    {
    char* temp = (char*)malloc(20);  // 动态分配空间
    // snprintf(temp, 20, "%d", $1);    // 转换成str再传参
    (yyval) = strdup(temp); 
}
    break;

  case 29:

/* Line 1464 of yacc.c  */
#line 174 "parser.y"
    {
    (yyval) = strdup((yyvsp[(1) - (1)])); // 本身就是str，直接传值
}
    break;

  case 30:

/* Line 1464 of yacc.c  */
#line 176 "parser.y"
    {
    new_temp(&(yyval), get_temp_index(list));
    gen_3addr(list, (yyval), (yyvsp[(1) - (3)]), "+", (yyvsp[(3) - (3)]));

}
    break;

  case 31:

/* Line 1464 of yacc.c  */
#line 180 "parser.y"
    {
    new_temp(&(yyval), get_temp_index(list));
    gen_3addr(list, (yyval), (yyvsp[(1) - (3)]), "-", (yyvsp[(3) - (3)]));

}
    break;

  case 32:

/* Line 1464 of yacc.c  */
#line 184 "parser.y"
    {
    new_temp(&(yyval), get_temp_index(list)); 
    gen_3addr(list, (yyval), (yyvsp[(1) - (3)]), "*", (yyvsp[(3) - (3)]));

}
    break;

  case 33:

/* Line 1464 of yacc.c  */
#line 188 "parser.y"
    {
    new_temp(&(yyval), get_temp_index(list)); 
    gen_3addr(list, (yyval), (yyvsp[(1) - (3)]), "/", (yyvsp[(3) - (3)]));
}
    break;

  case 34:

/* Line 1464 of yacc.c  */
#line 195 "parser.y"
    {
    backpatch(list, (yyvsp[(1) - (4)]).truelist, (yyvsp[(3) - (4)]).instr);
            (yyval).falselist = (yyvsp[(4) - (4)]).falselist; 
            (yyval).truelist = merge((yyvsp[(1) - (4)]).truelist, (yyvsp[(4) - (4)]).truelist); 
}
    break;

  case 35:

/* Line 1464 of yacc.c  */
#line 199 "parser.y"
    {

}
    break;

  case 36:

/* Line 1464 of yacc.c  */
#line 203 "parser.y"
    {
    backpatch(list, (yyvsp[(1) - (4)]).falselist, (yyvsp[(3) - (4)]).instr);
    (yyval).truelist = (yyvsp[(4) - (4)]).truelist; 
    (yyval).falselist = merge((yyvsp[(1) - (4)]).falselist, (yyvsp[(4) - (4)]).falselist); 
}
    break;

  case 37:

/* Line 1464 of yacc.c  */
#line 207 "parser.y"
    {

}
    break;

  case 38:

/* Line 1464 of yacc.c  */
#line 211 "parser.y"
    {

}
    break;

  case 39:

/* Line 1464 of yacc.c  */
#line 213 "parser.y"
    {
    (yyval).falselist = (yyvsp[(2) - (2)]).truelist; 
    (yyval).truelist = (yyvsp[(2) - (2)]).falselist;
}
    break;

  case 40:

/* Line 1464 of yacc.c  */
#line 219 "parser.y"
    {

}
    break;

  case 41:

/* Line 1464 of yacc.c  */
#line 221 "parser.y"
    { // <标识符> <关系符> <标识符>│<算术表达式> <关系符> <算术表达式>

}
    break;

  case 42:

/* Line 1464 of yacc.c  */
#line 231 "parser.y"
    {
    (yyval).truelist = new_instrlist(nextinstr(list));
    (yyval).falselist = new_instrlist(nextinstr(list)+1);
    char op[1]={<};
    gen_if(list, (yyvsp[(1) - (3)]), op, (yyvsp[(3) - (3)]));
    gen_goto_blank(list);
    
}
    break;

  case 43:

/* Line 1464 of yacc.c  */
#line 238 "parser.y"
    {
    (yyval).truelist = new_instrlist(nextinstr(list));
    (yyval).falselist = new_instrlist(nextinstr(list)+1);
    char op[2]={<=};
    gen_if(list, (yyvsp[(1) - (3)]), op, (yyvsp[(3) - (3)]));
    gen_goto_blank(list);
    
}
    break;

  case 44:

/* Line 1464 of yacc.c  */
#line 245 "parser.y"
    {
    (yyval).truelist = new_instrlist(nextinstr(list));
    (yyval).falselist = new_instrlist(nextinstr(list)+1);
    char op[1]={>};
    gen_if(list, (yyvsp[(1) - (3)]), op, (yyvsp[(3) - (3)]));
    gen_goto_blank(list);
    
}
    break;

  case 45:

/* Line 1464 of yacc.c  */
#line 252 "parser.y"
    {
    (yyval).truelist = new_instrlist(nextinstr(list));
    (yyval).falselist = new_instrlist(nextinstr(list)+1);
    char op[2]={>=};
    gen_if(list, (yyvsp[(1) - (3)]), op, (yyvsp[(3) - (3)]));
    gen_goto_blank(list);
    
}
    break;

  case 46:

/* Line 1464 of yacc.c  */
#line 259 "parser.y"
    {
    (yyval).truelist = new_instrlist(nextinstr(list));
    (yyval).falselist = new_instrlist(nextinstr(list)+1);
    char op[1]={=};
    gen_if(list, (yyvsp[(1) - (3)]), op, (yyvsp[(3) - (3)]));
    gen_goto_blank(list);
    
}
    break;

  case 47:

/* Line 1464 of yacc.c  */
#line 270 "parser.y"
    { (yyval).instr = nextinstr(list); }
    break;

  case 48:

/* Line 1464 of yacc.c  */
#line 273 "parser.y"
    {
            (yyval).nextlist = new_instrlist(nextinstr(list));
                    gen_goto_blank(list);
        }
    break;



/* Line 1464 of yacc.c  */
#line 1982 "y.tab.c"
      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined(yyoverflow) || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}



/* Line 1684 of yacc.c  */
#line 323 "parser.y"


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
    extern FILE *yyin;
    list = newcodelist();

    freopen("test.in", "rt+", stdin);
    
    yyparse();
    print(list);
    fclose(stdin);
    return 0;
}
// Linux 下注释掉这个函数
void yyerror(char *msg) {
    fprintf(stderr, "[%s] encountered at line %d.\nUnexpected character is: %s\n",msg, yylineno, removeNewline(yytext));
    return 0;
}
// Linux 下注释掉这个函数
int yywrap(){
    return 1;
}


