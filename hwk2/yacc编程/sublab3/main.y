/*

yacc程序补充第三问
2113999-陈翊炀
2023/10/10

*/
%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>
#define YYSTYPE char* //TYPE声明为char
char idStr[50];
char numStr[50];
int yylex ();
int isIdStr(int);
extern int yyparse();
FILE* yyin ;
void yyerror(const char* s);
%}

%token T_NUM
%token T_ID
%token T_ADD
%token T_MINUS
%token T_MULTIPLY
%token T_DIVIDE
%token T_LPAREN
%token T_RPAREN
%left T_ADD T_MINUS
%left T_MULTIPLY T_DIVIDE
%right UMINUS

%%


lines   :   lines expr ';' { printf("%s\n", $2); }
        |   lines ';'
        |
        ;

expr    :   expr T_ADD expr { $$ = (char*)malloc(50*sizeof(char)); strcpy($$,$1); 
                                    strcat($$,$3); strcat($$,"+ "); }
                                    //对于二元运算符（T_ADD、T_MINUS、T_MULTIPLY、T_DIVIDE），
                                    //相应的产生式将左侧表达式（$1）和右侧表达式（$3）合并，
                                    //并在它们之间插入对应的运算符（+、-、*、/），返回合并后的字符串。
        |   expr T_MINUS expr { $$ = (char*)malloc(50*sizeof(char)); strcpy($$,$1); 
                                      strcat($$,$3); strcat($$,"-"); }
        |   expr T_MULTIPLY expr 
            { $$ = (char*)malloc(50*sizeof(char)); strcpy($$,$1); strcat($$,$3);strcat($$,"* "); }
        |   expr T_DIVIDE expr 
            { $$ = (char*)malloc(50*sizeof(char)); strcpy($$,$1); strcat($$,$3); strcat($$,"/ "); }
            //括号直接返回
        |   T_LPAREN expr T_RPAREN { $$ = (char*)malloc(50*sizeof(char)); strcpy($$,$2); }
            //对于一元负号运算符（T_MINUS），产生式在表达式前添加负号（-），然后返回带有负号的表达式字符串。
        |   T_MINUS expr %prec UMINUS 
            { $$ = (char*)malloc(50*sizeof(char)); strcpy($$,"-"); strcat($$,$2); strcat($$," "); }
        |   T_NUM { $$ = (char*)malloc(50*sizeof(char)); strcpy($$,$1); strcat($$," "); }
        |   T_ID { $$ = (char*)malloc(50*sizeof(char)); strcpy($$,$1); strcat($$," "); }
        ;

%%



int yylex()
{
      int t;
      while(1){
          t=getchar();     
          if(t==' '||t=='\t'||t=='\n')
          {
            //空格、制表符等不做处理
          }
          else if((t>='0'&& t<='9'))
          {
                  int ti=0;
                  while((t>='0'&& t<='9'))
                  {
                  numStr[ti]=t;//暂时在数组中保存数字
                  t=getchar();
                  ti++;
                }
           numStr[ti]='\0';//设置终止符，转换为字符串
           yylval=numStr;
           ungetc(t,stdin);
           return T_NUM;
         }
         else if(isIdStr(t))
         {
            int id = 0;
            while(isIdStr(t)||(t>='0'&& t<='9'))
            {
                idStr[id] = t;
                t = fgetc(yyin);
                id++;
            }
            idStr[id] = '\0';
            yylval = idStr;
            ungetc(t,yyin);
            return T_ID;
        }
         else{
            switch(t){
                case '+':return T_ADD;
                case '-':return T_MINUS;
                case '*':return T_MULTIPLY;
                case '/':return T_DIVIDE;
                case '(':return T_LPAREN;
                case ')':return T_RPAREN;
                default: return t;
                      } 
              }
}
}
int main(void)
{
   yyin = stdin;
  do{
      yyparse();
    }while(!feof(yyin));
  return 0;
}

void yyerror(const char* s)
{
   fprintf(stderr,"Parse error:%s\n",s);
   exit(1);
}


int isIdStr(int t)
{
    if(t >= 'a' && t <= 'z')
    {
        return 1;
    }else if(t >= 'A' && t <= 'Z')
    {
        return 1;
    }else if(t == '_')
    {
        return 1;
    }else
    {
        return 0;
    }
}
