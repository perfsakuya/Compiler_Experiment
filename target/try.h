#ifndef CP_H
#define CP_H

#include <stdio.h>
#include <string.h>
#include <malloc.h>

typedef struct listele
//list element 列表元素
{
    int instrno;
    struct listele* next;
}listele;

listele* new_listele(int no)
// new list element 新建元素
{
    listele* p = (listele*)malloc(sizeof(listele));
    p->instrno = no;
    p->next = NULL;
    return p;
}


typedef struct instrlist
//instruction list 指令列表
{
    listele* first, * last;
}instrlist;

instrlist* new_instrlist(int instrno)
//new instruct8ion list 新指令列表
{
    instrlist* p = (instrlist*)malloc(sizeof(instrlist));
    p->first = p->last = new_listele(instrno);
    return p;
}

instrlist* merge(instrlist* list1, instrlist* list2)
//合并两个指令列表
{
    instrlist* p;
    if (list1 == NULL) p = list2;
    else
    {
        if (list2 != NULL)
        {
            if (list1->last == NULL)
            {
                list1->first = list2->first;
                list1->last = list2->last;
            }
            else list1->last->next = list2->first;
            list2->first = list2->last = NULL;
            free(list2);
        }
        p = list1;
    }
    return p;
}

typedef struct node
//中间代码节点
{
    instrlist* truelist, * falselist, * nextlist;
    char addr[256];
    char lexeme[256];
    char oper[3];
    int instr;
}node;

int filloperator(node* dst, char* src)
//fill operator操作符复制到节点
{
    strcpy(dst->oper, src);
    return 0;
}
int filllexeme(node* dst, char* yytext)
//fill exe meaning (?) 为什么不用morpheme 将词素复制到节点
{
    strcpy(dst->lexeme, yytext);
    return 0;
}
int copyaddr(node* dst, char* src)
//copy address 将地址复制到节点
{
    strcpy(dst->addr, src);
    return 0;
}
int new_temp(node* dst, int index)
{
    sprintf(dst->addr, "T%d", index);
    return 0;
}
int copyaddr_fromnode(node* dst, node src)
{
    strcpy(dst->addr, src.addr);
    return 0;
}

typedef struct codelist
//codelist 中间代码的列表
{
    int linecnt, capacity;
    int temp_index;
    char** code;
}codelist;

codelist* newcodelist()
//new code lilst 新中间代码列表
{
    codelist* p = (codelist*)malloc(sizeof(codelist));
    p->linecnt = 1;
    p->capacity = 1024;
    p->temp_index = 1;
    p->code = (char**)malloc(sizeof(char*) * 1024);
    return p;
}

int get_temp_index(codelist* dst)
//get index 获得临时变量的索引
{
    return dst->temp_index++;
}

int nextinstr(codelist* dst) { return dst->linecnt; }
//next instruction line 下一条中间代码行数
int Gen(codelist* dst, char* str)
//中间代码生成
{

    if (dst->linecnt >= dst->capacity)
    {
        dst->capacity += 1024;
        dst->code = (char**)realloc(dst->code, sizeof(char*) * dst->capacity);
        if (dst->code == NULL)
        {
            printf("short of memeory\n");
            return 0;
        }
    }
    dst->code[dst->linecnt] = (char*)malloc(strlen(str) + 20);
    strcpy(dst->code[dst->linecnt], str);
    dst->linecnt++;
    return 0;
}

char tmp[1024];
int gen_goto_blank(codelist* dst)
//geterate goto blank跳转中间代码 目标暂时为空
{
    sprintf(tmp, "(j, -, - ,");
    Gen(dst, tmp);
    return 0;
}

int gen_goto(codelist* dst, int instrno)
//generate goto无条件跳转的中间代码 目标instrno
{
    //sprintf(tmp, "goto %d", instrno);
    sprintf(tmp, "(j, -, -, %d)", instrno);
    Gen(dst, tmp);
    return 0;
}

int gen_if(codelist* dst, node left, char* op, node right)
//generate if条件跳转的中间代码 目标暂时为空
{
    //sprintf(tmp, "if %s %s %s goto", left.addr, op, right.addr);
    sprintf(tmp, "(j%s, %s, %s,", op, left.addr, right.addr);
    Gen(dst, tmp);
    return 0;
}

int gen_1addr(codelist* dst, node left, char* op)
//generate 1 address生成单地址中间代码
{
    sprintf(tmp, "%s %s", left.addr, op);
    Gen(dst, tmp);
    return 0;
}

int gen_2addr(codelist* dst, node left, char* op, node right)
//二地址中间代码
{
    //sprintf(tmp, "%s = %s %s", left.addr, op, right.addr);
    sprintf(tmp, "(%s, %s, -, %s)", op, right.addr, left.addr);
    Gen(dst, tmp);
    return 0;
}

int gen_3addr(codelist* dst, node left, node op1, char* op, node op2)
//三地址中间代码
{
    //sprintf(tmp, "%s = %s %s %s", left.addr, op1.addr, op, op2.addr);
    sprintf(tmp, "(%s, %s, %s, %s) ", op, op1.addr, op2.addr, left.addr);
    Gen(dst, tmp);
    return 0;
}

int gen_assignment(codelist* dst, node left, node right)
//generate assignment 生成赋值代码
{
    gen_2addr(dst, left, ":=", right);
    return 0;
}

int backpatch(codelist* dst, instrlist* list, int instrno)
//回填函数
{
    if (list != NULL)
    {
        listele* p = list->first;
        char tmp[20];

        sprintf(tmp, " %d)", instrno);
        while (p != NULL)
        {
            if (p->instrno < dst->linecnt)
                strcat(dst->code[p->instrno], tmp);
            p = p->next;
        }
    }
    return 0;
}
int print(codelist* dst)
{
    int i;

    for (i = 1; i < dst->linecnt; i++)
        printf("(%d)   %s\n", i, dst->code[i]);
    printf("(%d)   %s\n", i, "(sys, -, -, -)");
    return 0;
}

#endif