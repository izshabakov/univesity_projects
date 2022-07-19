/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    NUMBER = 258,
    IDENTIFIER = 259,
    DOWHILE = 260,
    ENDDO = 261,
    SEMICOLON = 262,
    LOOP = 263,
    EXIT = 264,
    OP = 265,
    CP = 266,
    LESS = 267,
    GREATER = 268,
    LEQ = 269,
    GEQ = 270,
    NEQ = 271,
    STR_EQ = 272,
    OR = 273,
    AND = 274,
    NOT = 275,
    EQUAL = 276,
    PLUS = 277,
    MINUS = 278,
    MULTIPLY = 279,
    DIVIDE = 280
  };
#endif
/* Tokens.  */
#define NUMBER 258
#define IDENTIFIER 259
#define DOWHILE 260
#define ENDDO 261
#define SEMICOLON 262
#define LOOP 263
#define EXIT 264
#define OP 265
#define CP 266
#define LESS 267
#define GREATER 268
#define LEQ 269
#define GEQ 270
#define NEQ 271
#define STR_EQ 272
#define OR 273
#define AND 274
#define NOT 275
#define EQUAL 276
#define PLUS 277
#define MINUS 278
#define MULTIPLY 279
#define DIVIDE 280

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 3 "while.y"

        int num;
        char *str;

#line 112 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
