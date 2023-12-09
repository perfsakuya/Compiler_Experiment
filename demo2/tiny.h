#include <stdio.h>
#include <string.h>
#include <malloc.h>

// 定义一个结构体，表示一个列表元素，包含一个指令编号和一个指向下一个元素的指针
typedef struct listele
{
 int instrno;
 struct listele *next;
}listele;

// 创建一个新的列表元素，分配内存空间，并初始化指令编号和指针
listele* new_listele(int no)
 {
     listele* p = (listele*)malloc(sizeof(listele));
     p->instrno = no;
     p->next = NULL;
     return p;
 }


// 定义一个结构体，表示一个指令列表，包含一个指向第一个元素的指针和一个指向最后一个元素的指针
typedef struct instrlist
{
 listele *first,*last;
}instrlist;

// 创建一个新的指令列表，分配内存空间，并初始化第一个和最后一个元素为同一个新的列表元素
 instrlist* new_instrlist(int instrno)
 {
     instrlist* p = (instrlist*)malloc(sizeof(instrlist));
     p->first = p->last = new_listele(instrno);
     return p;
 }

// 定义一个结构体，表示一个代码列表，包含一个行数计数器，一个容量，一个临时变量索引，和一个指向代码字符串数组的指针
typedef struct codelist
{
 int linecnt, capacity;
 int temp_index;
 char **code;
}codelist;

// 创建一个新的代码列表，分配内存空间，并初始化行数计数器为100，容量为1024，临时变量索引为100，代码字符串数组为1024个元素
 codelist* newcodelist()
 {
     codelist* p = (codelist*)malloc(sizeof(codelist));
     p->linecnt = 100;
     p->capacity = 1024;
     p->temp_index = 100;
     p->code = (char**)malloc(sizeof(char*)*1024);
     return p;
 }


// 合并两个指令列表，返回一个新的指令列表，如果其中一个列表为空，则返回另一个列表，如果两个列表都不为空，则将第一个列表的最后一个元素的指针指向第二个列表的第一个元素，并释放第二个列表的内存空间
 instrlist* merge(instrlist *list1, instrlist *list2)
 {
     instrlist *p;
     if (list1 == NULL) p = list2;
     else
     {
         if (list2!=NULL)
         {
             if (list1->last == NULL)
             {
                 list1->first = list2->first;
                 list1->last =list2->last;
             }else list1->last->next = list2->first;
             list2->first = list2->last = NULL;
             free(list2);
         }
         p = list1;
     }
     return p;
 }
// 对一个指令列表进行回填，将指定的指令编号追加到代码列表中对应的行的末尾，返回0表示成功
 int backpatch(codelist *dst, instrlist *list, int instrno)
 {
     if (list!=NULL)
     {
         listele *p=list->first;
         char tmp[20];
     
         sprintf(tmp, " %d)", instrno);
         while (p!=NULL)
         {
             if (p->instrno < dst->linecnt)
                 strcat(dst->code[p->instrno], tmp);
             p=p->next;
         }
     }
     return 0;
 }
