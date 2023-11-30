%option noyywrap
%option nounput
%option noinput
%option yylineno
%top{
    #include <stdarg.h>
    #include "common.h"
}
%{
    struct SymbolTables{//符号表
  
        char symbol_name[50];
        char* attribute;
    
        
    };
    typedef struct SymbolTables STE;

    int yycolumnno=0;//列号
    STE test_symbol[100];

    int symbol_num = 0;
    STE* insert(char* name,char* attribute){
        STE* location = test_symbol + symbol_num;
        strcpy(location->symbol_name , name);
        location->attribute=attribute;
        symbol_num++;
        return location;
    }   

    STE* search(char* name){
     STE* location = test_symbol;
     for(int i=0;i<symbol_num;i++){
        //printf("%s\n", name);
        if(strcmp(location->symbol_name , name)==0){
            return location;
        }
        location+=1;
     }
     return NULL;
    } 

    extern dump_type_t dump_type;

    inline void dump_tokens(const char* format, ...){
        va_list args;
        va_start(args, format);
        if (dump_type == TOKENS)
            vfprintf(yyout, format, args);
        va_end(args);
        yycolumnno+=yyleng;
    }

%}

/* definitions section */
splice  (\\[[:blank:]]*\n)*
digit   [0-9]
letter [A-Za-z]
EXP ([Ee][-+]?[0-9]+)
FLOAT (([0-9]*\.[0-9]+|[0-9]+\.){EXP}?)
DEC (0|[1-9][0-9]*)
OCT (0[1-7][0-7]*|00)
HEX (((0X|0x)[0-9a-fA-F]*)|0x0|0X0)
ID [[:alpha:]_][[:alpha:][:digit:]_]*
EOL (\r\n|\n|\r)
WHITE [\t ]
MultilineComment "/*"([^\*]|(\*)*[^\*/]*(\*)*)"*/"
SinglelineComment "//".*$

/*  Your code here (lab3). */



%%
    /* rules section */

"const" {
    dump_tokens("CONST\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}

"int" {
    dump_tokens("INT\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
"float" {
    dump_tokens("float\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}

"void" {
    dump_tokens("VOID\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}

"if" {
    dump_tokens("IF\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}

"else" {
    dump_tokens("ELSE\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}

"return" {
    dump_tokens("RETURN\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
"while" {
    dump_tokens("WHILE\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
"for" {
    dump_tokens("FOR\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
"break" {
    dump_tokens("BREAK\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}   
"continue" {
    dump_tokens("CONTINUE\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
"=" {
    dump_tokens("ASSIGN\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}

"<" {
    dump_tokens("LESS\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
">" {
    dump_tokens("GREATER\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
"<=" {
    dump_tokens("LORE\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
">=" {
    dump_tokens("GORE\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
"==" {
    dump_tokens("EQUAL\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
"!=" {
    dump_tokens("NOTEQUAL\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
"&&" {
    dump_tokens("AND\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
"||" {
    dump_tokens("OR\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}

"!" {
    dump_tokens("NON\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
"+" {
    dump_tokens("ADD\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
"-" {
    dump_tokens("MINUS\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
"*" {
    dump_tokens("MUL\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
"/" {
    dump_tokens("DIV\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
"%" {
    dump_tokens("MOD\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
";" {
    dump_tokens("SEMICOLON\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}

"(" {
    dump_tokens("LPAREN\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}

")" {
    dump_tokens("RPAREN\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
"[" {
    dump_tokens("LBRACK\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
"]" {
    dump_tokens("RBRACK\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
"," {
    dump_tokens("COMMA\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}
"{" {
    dump_tokens("LBRACE\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}

"}" {
    dump_tokens("RBRACE\t%s\t%d\t%d\n", yytext,yylineno,yycolumnno);
}

{ID} {
    STE* symbol = search(yytext);
    if (symbol == NULL) {
        symbol = insert(yytext, NULL);
    }
    dump_tokens("ID\t%s\t%d\t%d\t%p\n", yytext,yylineno,yycolumnno,symbol);
}
{FLOAT} {
     dump_tokens("FLOAT\t%s\t%d\t%d\t%g\n", yytext, yylineno, yycolumnno, yytext);
}
{OCT} {

    int len = yyleng - 1;
    int sum = 0;
    for (int i = 0; i < len; i++) 
    {
        int temp1 = 1;
        int temp2 = yytext[i + 1] - '0';
        for (int j = 0; j < len - i - 1; j++) 
        {
            temp1 *= 8;
        }
        sum += temp1 * temp2;
    }
    dump_tokens("OCT\t%s\t%d\t%d\t%d\n", yytext, yylineno, yycolumnno, sum);
}
    
{DEC} { dump_tokens("DEC\t%s\t%d\t%d\t%s\n", yytext, yylineno, yycolumnno,yytext);}
{HEX} {
    char *a = yytext;
    int len = strlen(a) - 2;
    int sum = 0;

for (int i = 0; i < len; i++) {
    int temp1 = 1;
    int temp2 = 0;

    if (a[i + 2] >= '0' && a[i + 2] <= '9') {
        temp2 = a[i + 2] - '0';
    } else if (a[i + 2] >= 'A' && a[i + 2] <= 'F') {
        temp2 = a[i + 2] - 'A' + 10;
    } else if (a[i + 2] >= 'a' && a[i + 2] <= 'f') {
        temp2 = a[i + 2] - 'a' + 10;
    }

    for (int j = 0; j < len - i - 1; j++) {
        temp1 *= 16;
    }

    sum += temp1 * temp2;
}

    dump_tokens("HEX\t%s\t%d\t%d\t%d\n", yytext, yylineno, yycolumnno, sum);
}
{MultilineComment} {

}
{SinglelineComment} {

}
{EOL} {yycolumnno=0;}

{WHITE} {
    yycolumnno+=1;
}


. {
    // Ignore unknown characters
}
%%
/* user code section */

