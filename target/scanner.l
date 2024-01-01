%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h" // 由 yacc -d 生成
// #define MAX_SIZE 100
// int wordcount = 0;
%}
%option yylineno
letter      [A-Za-z]
digit       [0-9]
 // <标识符> → <字母>│<标识符> <数字>│<标识符> <字母>
identifier {letter}({letter}|{digit})*
 // identifier ({letter}|_){letter}({letter}|{digit}|_)* // 貌似会产生奇怪的bug
 //整数
integer {digit}+
 //字符常数和错误的字符常数
 //char_num '{letter}*'
char_const ['][^']*[']
false_char_const ['][^']*
 //注释和错误的注释
comment [/][*].*[*][/]
false_comment [/][*].*
%%

[ \t\r\a]+     ; // 空白字符
[\n]         return LF; // 换行符
and          return AND;
array        return ARR;
begin        return BEG;
bool         return BOOL;
call         return CALL;
case         return CASE;
char         return CHR;
constant     return CONST;
dim          return DIM;
do           return DO;
else         return ELSE;
end          return END;
false        return BOOLFALSE;
for          return FOR;
if           return IF;
input        return INPUT;
integer      return INT;
not          return NOT;
of           return OF;
or           return OR;
output       return OUTPUT;
procedure    return PROCEDURE;
program      return PROGRAM;
read         return READ;
real         return REAL;
repeat       return REPEAT;
set          return SET;
stop         return STOP;
then         return THEN;
to           return TO;
true         return BOOLTRUE;
until        return UNTIL;
var          return VAR;
while        return WHILE;
write        return WRITE;
"("          return LB;
")"          return RB;
"*"          return MUL;
"*/"         return RCOMMENT;
"+"          return ADD;
","          return COMMA;
"-"          return SUB;
"."          return DOT;
".."         return TDOT;
"/"          return DIV;
"/*"         return LCOMMENT;
":"          return COLON;
":="         { filloperator(&yylval, yytext); return ASSIGN; }
";"          return SEMI;
"<"|"<="|">"|">="|"!="|"="    { filloperator(&yylval, yytext); return( RELOP ); }
"["          return LC;
"]"          return RC;


{identifier} {  // 标识符

    // yylval.str = strdup(yytext); // 弃用
    filllexeme(&yylval, yytext);
    return id; // 在test里面是大写ID
}
{integer}    { 
    // yylval.num = atoi(yytext);  // 弃用
    filllexeme(&yylval, yytext);
    return INTEGER; // 在test里面是NUMBER
}
{char_const} { //字符常数

    return TRUECHAR;
}
{false_char_const} { //错误字符常数
    printf("Wrong Character Constant Format: %s\n", yytext); 
    return FALSECHAR;
}
{comment} {  // 注释
    //printf("This is a comment, do not show this: %s\n", yytext); 
    return TRUECOMMENT;
}
{false_comment} {  // 错误注释
    printf("Wrong Comment Format: %s\n", yytext); 
    return FALSECOMMENT;
}

. {  //其他非法字符
    printf("Illegal character: %s\n",yytext);
    return ILLEGALCHR;
}

%%

// // 定义键值对的结构体
// struct KeyValue {
//     char key[32];
//     int value;
// };

// // 定义map结构体
// struct Map {
//     struct KeyValue data[MAX_SIZE];
//     int size;
// };

// // 初始化map
// void initMap(struct Map *map) {
//     map->size = 0;
// }

// // 插入键值对
// int insert(struct Map *map, const char *key) {
//     if (map->size < MAX_SIZE) {
//         strcpy(map->data[map->size].key, key);
//         map->data[map->size].value = map->size + 1; // 设置值为键值对在map中的位置+1
//         map->size++;
//         return map->size - 1; // 返回刚插入的键值对的位置
//     } else {
//         printf("Map is full, cannot insert more elements.\n");
//         return -1;
//     }
// }

// // 查找键对应的值
// int get(struct Map *map, const char *key) {
//     for (int i = 0; i < map->size; i++) {
//         if (strcmp(map->data[i].key, key) == 0) {
//             return i; // 返回键值对在map中的位置
//         }
//     }
//     return -1;  // 返回-1表示未找到
// }

// // 增加与给定字符串关联的键值对的值
// void incrementValue(struct Map *map, const char *key) {
//     for (int i = 0; i < map->size; i++) {
//         if (strcmp(map->data[i].key, key) == 0) {
//             map->data[i].value++;
//         }
//     }
// }


//     if (map->size < MAX_SIZE) {
//         strcpy(map->data[map->size].key, key);
//         map->data[map->size].value = map->size + 1; // 设置值为键值对在map中的位置+1
//         map->size++;
//         return map->size - 1; // 返回刚插入的键值对的位置
//     } else {
//         printf("Map is full, cannot insert more elements.\n");
//         return -1;
//     }
// }
// // 删除键值对
// void erase(struct Map *map, const char *key) {
//     for (int i = 0; i < map->size; i++) {
//         if (strcmp(map->data[i].key, key) == 0) {
//             for (int j = i; j < map->size - 1; j++) {
//                 map->data[j] = map->data[j + 1];
//             }
//             map->size--;
//             return;
//         }
//     }
// }

//废除的主函数
// int main(int argc, char const *argv[]) {
//     int type;
//     char filename[64];
//     struct Map map;
//     int flag = 0;
//     initMap(&map);

//     printf("Enter the name of the program file: ");  //读取文件
//     scanf("%s", filename);
//     FILE *file = fopen(filename, "r");
//     if (file == NULL) {
//         printf("Error: Cannot open the file %s.\n", filename);
//         return 1;
//     }

//     yyin = file;
//     while (type = yylex()) {
//         if(type <= 9)  //为了美观设置的格式化输出
//         {    
//             printf("( %d, - )  ", type);
//             flag++;
//             if(flag%5 == 0)
//             printf("\n");
//         }
//         else if(type == 36 | type == 37 | type == 38)  //标识符/整数/字符常数
//         {    
//             //printf("starting...\n");
//             if(get(&map, yytext) == -1 ) {  //判断是新的标识符，加入哈希表
//                 wordcount++;
//                 insert(&map, yytext);
//             }
//             else {  //判断为旧的标识符，将对应的value++
//                 incrementValue(&map, yytext);
//             }
//             printf("(%d, %d )  ", type, get(&map, yytext)+1);
//             flag++;
//             if(flag%5 == 0)
//                 printf("\n");
//         }
//         else if(type == 300 | type == 301 | type == 302 | type == 303)  //抛出错误
//             ; // do nothing
//         else 
//         {
//             printf("(%d, - )  ", type);
//             flag++;
//             if(flag%5 == 0)
//             printf("\n");
//         }
//     }

//     fclose(file);  //关闭文件
//     return 0;
// }

// int yywrap() {
//     return 1;
// }
