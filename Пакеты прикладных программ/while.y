//yylval принимает значение int и string
%union 
{
        int num;
        char *str;
}
//Числа принимают значение int
%token <num> NUMBER 
//Переменные принимают значения string
%token <str> IDENTIFIER
%token DOWHILE ENDDO
%token SEMICOLON
%token LOOP EXIT
//Выражения принимают значения string
%type <num> exp term

//Приоритет операций. Чем ниже строка, тем выше приоритет
%left OP CP
%left LESS GREATER LEQ GEQ NEQ STR_EQ
%left OR
%left AND
%left NOT
%right EQUAL
%left PLUS MINUS
%left MULTIPLY DIVIDE

%{
#include <stdio.h>	
#include <stdlib.h>
//Подключение переменных
#include "variables.h"

void yyerror(char *);
extern int yylex(void);
extern int yylineno;
extern int column;
extern int error_count;

symbol_block *symtab = NULL;
%}


%%
commands: /* пусто */
                    | commands exp SEMICOLON {printf("Вычисленное выражение: %d\n", $2);}
                    | commands command SEMICOLON
                    | commands command error { yyerror("Пропущена точка с запятой");}
                    | commands error SEMICOLON { yyerror("Неправильная команда");}
                    | commands LOOP SEMICOLON  { yyerror("LOOP вне DO WHILE");}
                    | commands EXIT SEMICOLON  { yyerror("EXIT вне DO WHILE");}
                    ;

command:            
                      DOWHILE lexp commands while_st ENDDO
                    | IDENTIFIER EQUAL exp {
                        symbol_assign(&symtab, $1, $3);} 
                    | IDENTIFIER error exp { yyerror("Ошибка в присвоении значения переменной"); }
                    ;


while_st:           | EXIT 
                    | LOOP
                    ;

exp:           
                      term
                    | exp PLUS exp            { $$ = $1 + $3;   }
                    | exp MINUS exp           { $$ = $1 - $3;   }
                    | exp MULTIPLY exp        { $$ = $1 * $3;   }
                    | exp DIVIDE exp          {
                                                if ($3)
                                                $$ = $1 / $3;
                                                else
                                               {
                                                yyerror("Деление на ноль");
                                                $$=0;
                                              }            
                                              }
                     | OP exp CP              { $$ = $2;        }
                     ;

lexp:                  exp LESS exp           {printf("Выражение слева: %d\nВыражение справа: %d\n", $1, $3);} 
                     | exp GREATER exp        {printf("Выражение слева: %d\nВыражение справа: %d\n", $1, $3);} 
                     | exp LEQ exp            {printf("Выражение слева: %d\nВыражение справа: %d\n", $1, $3);} 
                     | exp GEQ exp            {printf("Выражение слева: %d\nВыражение справа: %d\n", $1, $3);} 
                     | exp NEQ exp            {printf("Выражение слева: %d\nВыражение справа: %d\n", $1, $3);} 
                     | exp STR_EQ exp         {printf("Выражение слева: %d\nВыражение справа: %d\n", $1, $3);}
                     | exp error exp          { yyerror("Пропущен знак сравнения");}
                     | lexp AND lexp           
                     | lexp OR lexp            
                     | NOT lexp                
                     | OP lexp CP              
                     ;

term: 
                       NUMBER                    { $$ = $1; }
                     | IDENTIFIER {
                           int dst;
                           if (symbol_get_value(&symtab, &dst, $1) == 1) {
                                $$ = dst; printf("Переменная %s имеет значение %d\n", $1, $$);} 
                           else {
                                yyerror("Данной переменной не существует");}
                                  }
                 ;


%%
int main(int argc, char **argv){
    yyparse();
    if (error_count == 0) {
        printf("Ошибок в работе программы не обнаружено.\n");
    } else {
        printf("В ходе выполнения обнаружено %d ошибок.\n", error_count);
    }
} 

void yyerror(char *str) {
	if (strcmp(str, "syntax error")) { printf("На %d строке %d столбце обнаружена ошибка: %s\n", yylineno, column, str); error_count++; }
}


