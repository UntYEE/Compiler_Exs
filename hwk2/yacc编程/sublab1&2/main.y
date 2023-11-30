/*

yacc程序补充第一、二问
2113999-陈翊炀
2023/10/10

*/
%{
#include<stdio.h>
#include<stdlib.h>
#include<ctype.h>
#define YYSTYPE double
int yylex();
extern int yyparse();
FILE* yyin;
void yyerror(const char* s);
%}


%token T_NUM
%token T_ADD
%token T_MINUS
%token T_MULTIPLY
%token T_DIVIDE
%token T_LPAREN //左括号
%token T_RPAREN //右括号
%left T_ADD T_MINUS
%left T_MULTIPLY T_DIVIDE
%right UMINUS


%%

lines   :   lines expr ';' { printf("%f\n", $2); }
        |   lines ';'
        |
        ;
        
expr  :  expr T_ADD expr {$$=$1+$3;}
      |  expr T_MINUS expr {$$=$1-$3;}
      |  expr T_MULTIPLY expr {$$=$1*$3;}
      |  expr T_DIVIDE expr  
                {   if($3==0.0)//零单独讨论
                        yyerror("Zero cannot be a divisor.");
                    else
                        $$ = $1 / $3;
                }
      |  T_LPAREN expr T_RPAREN  {$$=$2;}
      |  T_MINUS expr %prec UMINUS {$$=-$2;}
      |  T_NUM 
      ;
%%

int yylex()
{
   int t;
   while(1)
   {
     t=getchar();
     
        if(t==' '||t=='\t'||t=='\n')
        {
            //空格、制表符等不做处理
        }
        else if(isdigit(t))
        {
            yylval=0;
            while(isdigit(t))
            {
            //连续识别整数按照乘十处理
              yylval=yylval*10+t-'0';
              t=getchar();
            }
            ungetc(t,stdin);
            return T_NUM;
        }
        else if(t=='+')
        {
            return T_ADD;
        }
        else if(t=='-')
        {
            return T_MINUS;
        }
        else if(t=='*')
        {
            return T_MULTIPLY;
        }
        else if(t=='/')
        {
            return T_DIVIDE;
        }
        else if(t=='(')
        {
            return T_LPAREN;
        }
        else if(t==')')
        {
            return T_RPAREN;
        }
        else{
            return t;
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

