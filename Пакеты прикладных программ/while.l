%option noyywrap
%option yylineno
%{
#include "y.tab.h"
#include <stdio.h>


int column = 0;
int error_count = 0;
%}

%%
DO" "WHILE              {column += yyleng;  printf("DO WHILE\n"); return DOWHILE; }
ENDDO                   {column += yyleng;  printf("ENDDO\n"); return ENDDO; }
LOOP                    {column += yyleng;  printf("LOOP\n"); return LOOP; }
EXIT                    {column += yyleng;  printf("EXIT\n"); return EXIT; }
"("			            {column += yyleng;  printf("LPAREN\n"); return OP;}
")"			            {column += yyleng;  printf("RPAREN\n"); return CP;}
"+" 			        {column += yyleng;  printf("PLUS\n"); return PLUS;}
"-"			            {column += yyleng;  printf("MINUS\n"); return MINUS;}
"*"			            {column += yyleng;  printf("MULTIPLY\n"); return MULTIPLY;}
"/" 			        {column += yyleng;  printf("DIVIDE\n"); return DIVIDE;}
AND			            {column += yyleng;  printf("AND\n"); return AND;}
OR			            {column += yyleng;  printf("OR\n"); return OR;}
NOT			            {column += yyleng;  printf("NOT\n"); return NOT;}
0|([1-9][0-9]*)         {column += yyleng;  yylval.num = atoi(yytext); return NUMBER;} 
[a-zA-Z][a-zA-Z0-9]*    {column += yyleng;  printf("IDENTIFIER = %s\n", yytext); yylval.str = strdup(yytext); return IDENTIFIER; }
;                       {column += yyleng;  printf("SEMICOLON\n"); return SEMICOLON; }              
[\n] 		            {column=0;}
[ \t]                   {column++;}
"<="                    {column += yyleng;  printf("LEQ\n"); return LEQ; }
">="                    {column += yyleng;  printf("GEQ\n"); return GEQ; }
"<>"|"#"|"!="           {column += yyleng;  printf("NEQ\n"); return NEQ; }
"=="                    {column += yyleng;  printf("STR_EQ\n"); return STR_EQ; }
"="                     {column += yyleng;  printf("EQUAL\n"); return EQUAL; }
"<"                     {column += yyleng;  printf("LESS\n"); return LESS; }
">"                     {column += yyleng;  printf("GREATER\n"); return GREATER; }

%%
