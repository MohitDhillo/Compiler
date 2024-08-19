/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton interface for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

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

/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     _PROGRAM = 258,
     _VAR = 259,
     _BEGIN = 260,
     _END = 261,
     _END_DOT = 262,
     _INTEGER = 263,
     _REAL = 264,
     _FOR = 265,
     _READ = 266,
     _WRITE = 267,
     _TO = 268,
     _DO = 269,
     _SEMICOLON = 270,
     _COLON = 271,
     _COMMA = 272,
     _ASSIGN = 273,
     _ADD = 274,
     _SUB = 275,
     _MUL = 276,
     _DIV = 277,
     _OPEN_BRACE = 278,
     _CLOSE_BRACE = 279,
     _FLOAT = 280,
     _ID = 281,
     _INT = 282
   };
#endif
/* Tokens.  */
#define _PROGRAM 258
#define _VAR 259
#define _BEGIN 260
#define _END 261
#define _END_DOT 262
#define _INTEGER 263
#define _REAL 264
#define _FOR 265
#define _READ 266
#define _WRITE 267
#define _TO 268
#define _DO 269
#define _SEMICOLON 270
#define _COLON 271
#define _COMMA 272
#define _ASSIGN 273
#define _ADD 274
#define _SUB 275
#define _MUL 276
#define _DIV 277
#define _OPEN_BRACE 278
#define _CLOSE_BRACE 279
#define _FLOAT 280
#define _ID 281
#define _INT 282




#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE
#line 76 "parser.y"
{
	struct Number{
		enum {INTEGER, REAL} type;
		union
		{
			float real;
			int integer;
		};
	}NUMBER;
	char* ID;
}
/* Line 1529 of yacc.c.  */
#line 115 "y.tab.h"
	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif

extern YYSTYPE yylval;

