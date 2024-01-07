%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#define MAX_SIZE 100
int wordcount = 0;
%}

letter      [A-Za-z]
digit       [0-9]
 // <标识符> → <字母>│<标识符> <数字>│<标识符> <字母>
identifier {letter}({letter}|{digit})*
 //整数
integer {digit}*
 //字符常数和错误的字符常数
 //char_num '{letter}*'
char_const ['][^']*[']
false_char_const ['][^']*
 //注释和错误的注释
comment [/][*].*[*][/]
false_comment [/][*].*
%%

[ \t\r\a]+     ; // 空白字符
[\n]           ; // 换行符
and          return 1;
array        return 2;
begin        return 3;
bool         return 4;
call         return 5;
case         return 6;
char         return 7;
constant     return 8;
dim          return 9;
do           return 10;
else         return 11;
end          return 12;
false        return 13;
for          return 14;
if           return 15;
input        return 16;
integer      return 17;
not          return 18;
of           return 19;
or           return 20;
output       return 21;
procedure    return 22;
program      return 23;
read         return 24;
real         return 25;
repeat       return 26;
set          return 27;
stop         return 28;
then         return 29;
to           return 30;
true         return 31;
until        return 32;
var          return 33;
while        return 34;
write        return 35;
"("          return 39;
")"          return 40;
"*"          return 41;
"*/"         return 42;
"+"          return 43;
","          return 44;
"-"          return 45;
"."          return 46;
".."         return 47;
"/"          return 48;
"/*"         return 49;
":"          return 50;
":="         return 51;
";"          return 52;
"<"          return 53;
"<="         return 54;
"<>"         return 55;
"="          return 56;
">"          return 57;
">="         return 58;
"["          return 59;
"]"          return 60;

{identifier} {  // 标识符
    //++wordcount;
    return 36;
}
{integer} {  // 整数
    //++wordcount;
    return 37;
}
{char_const} { //字符常数
    //++wordcount;
    return 38;
}
{false_char_const} { //错误字符常数
    printf("Wrong Character Constant Format: %s\n", yytext); 
    return 300;
}
{comment} {  // 注释
    //printf("This is a comment, do not show this: %s\n", yytext); 
    return 301;
}
{false_comment} {  // 错误注释
    printf("Wrong Comment Format: %s\n", yytext); 
    return 302;
}
. {  //其他非法字符
    printf("Illegal character: %s\n",yytext);
    return 303;
}

%%

// 定义键值对的结构体
struct KeyValue {
    char key[32];
    int value;
};

// 定义map结构体
struct Map {
    struct KeyValue data[MAX_SIZE];
    int size;
};

// 初始化map
void initMap(struct Map *map) {
    map->size = 0;
}

// 插入键值对
int insert(struct Map *map, const char *key) {
    if (map->size < MAX_SIZE) {
        strcpy(map->data[map->size].key, key);
        map->data[map->size].value = map->size + 1; // 设置值为键值对在map中的位置+1
        map->size++;
        return map->size - 1; // 返回刚插入的键值对的位置
    } else {
        printf("Map is full, cannot insert more elements.\n");
        return -1;
    }
}

// 查找键对应的值
int get(struct Map *map, const char *key) {
    for (int i = 0; i < map->size; i++) {
        if (strcmp(map->data[i].key, key) == 0) {
            return i; // 返回键值对在map中的位置
        }
    }
    return -1;  // 返回-1表示未找到
}

// 增加与给定字符串关联的键值对的值
void incrementValue(struct Map *map, const char *key) {
    for (int i = 0; i < map->size; i++) {
        if (strcmp(map->data[i].key, key) == 0) {
            map->data[i].value++;
        }
    }
}


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


int main(int argc, char const *argv[]) {
    int type;
    char filename[64];
    struct Map map;
    int flag = 0;
    initMap(&map);
    printf("Modified by ■■■, ■■■, ■■■■■■■■■■■■\n");
    
    printf("Enter the name of the program file: ");  //读取文件
    scanf("%s", filename);
    FILE *file = fopen(filename, "r");
    if (file == NULL) {
        printf("Error: Cannot open the file %s.\n", filename);
        return 1;
    }

    yyin = file;
    while (type = yylex()) {
        if(type <= 9)  //为了美观设置的格式化输出
        {    
            printf("( %d, - )  ", type);
            flag++;
            if(flag%5 == 0)
            printf("\n");
        }
        else if(type == 36 | type == 37 | type == 38)  //标识符/整数/字符常数
        {    
            //printf("starting...\n");
            if(get(&map, yytext) == -1 ) {  //判断是新的标识符，加入哈希表
                wordcount++;
                insert(&map, yytext);
            }
            else {  //判断为旧的标识符，将对应的value++
                incrementValue(&map, yytext);
            }
            printf("(%d, %d )  ", type, get(&map, yytext)+1);
            flag++;
            if(flag%5 == 0)
                printf("\n");
        }
        else if(type == 300 | type == 301 | type == 302 | type == 303)  //抛出错误
            ; // do nothing
        else 
        {
            printf("(%d, - )  ", type);
            flag++;
            if(flag%5 == 0)
            printf("\n");
        }
    }

    fclose(file);  //关闭文件
    return 0;
}

int yywrap() {
    return 1;
}
