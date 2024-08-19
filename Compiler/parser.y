%{
#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#define NOT_INIT -10000000
#define YYERROR_VERBOSE 

/* important declaration */
int yylex(void);  // Declaration for the lexer function
int yyparse(void);  // Declaration for the parser function

void init();  // Initialization function

int get_int_value(char*);  // Get integer value of a symbol
float get_real_value(char*);  // Get real value of a symbol
void set_int_value(char*, int);  // Set integer value of a symbol
void set_real_value(char*, float);  // Set real value of a symbol
int get_type(char*);  // Get type of a symbol
int set_type(int);  // Set type of symbols
int set_init();  // Initialize symbols
void clear_list();  // Clear symbol list

int is_initialized(char*);  // Check if symbol is initialized
int is_declared(char*);  // Check if symbol is declared

int add_id(char*);  // Add identifier to symbol table
void print_id_list(void);  // Print symbol table
void print_hash_table(void);  // Print hash table

int get_line_number(void);  // Get current line number

/* error handling */
void yyerror(const char *str)  // Error handling function
{
        fprintf(stderr,"error: %s, line number: %d\n",str, get_line_number() + 1);
}

int yywrap()  // Wrapper function for end-of-file handling
{
        return 1;
}

int main()  // Main function
{
	init();  // Initialize the parser
        yyparse();  // Start parsing
}

%}

// Tokens for lexical analysis

%token _PROGRAM		
%token _VAR		
%token _BEGIN		
%token _END		
%token _END_DOT		
%token _INTEGER		
%token _REAL		
%token _FOR		
%token _READ		
%token _WRITE		
%token _TO		
%token _DO		
%token _SEMICOLON	
%token _COLON		
%token _COMMA		
%token _ASSIGN		
%token _ADD		
%token _SUB		
%token _MUL		
%token _DIV		
%token _OPEN_BRACE	
%token _CLOSE_BRACE	
%union 
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

%token <NUMBER>  _FLOAT
%token <ID> _ID	
%token <NUMBER> _INT
%type <NUMBER> exp factor term

%left _ADD _SUB 
%left _MUL _DIV 

%%
program: _PROGRAM progname _VAR declist _BEGIN stmtlist _END_DOT { print_hash_table(); }
       ;

progname: _ID
	;

declist: dec
       | declist _SEMICOLON dec
       ;

dec: idlist _COLON type 
   ;

type: _INTEGER { 
    		if(!set_type(0)) 
    			yyerror("duplicate symbol semantic error");
	}
    | _REAL { 
    		if(!set_type(1))
    			yyerror("duplicate symbol semantic error");
	}
    ;

idlist: _ID { 
      		if(!add_id($1))
      			yyerror("duplicate symbol semantic error");

	}
      | idlist _COMMA _ID { 
      		if(!add_id($3))
      			yyerror("duplicate symbol semantic error");
	} 
      ;

stmtlist: stmt
	| stmtlist _SEMICOLON stmt
	;

stmt: assign 
    | read
    | write
    | for
    | error 
    ;

assign: _ID _ASSIGN exp { 
      		if(is_declared($1)) {
			if($3.type == get_type($1)) {
				if($3.type == 0) 
					set_int_value($1, $3.integer); 
				else if($3.type == 1)
					set_real_value($1, $3.real);
			}
			else 
				yyerror("type mismatch on assignment semantic error");// expression assignment mismatch
		}
		else
			yyerror("missing declaration semantic error");// error not declared symbol
	}
      ;

exp: exp _ADD term {
    		if($1.type == $3.type) {
			if($1.type == 0) {
    				$$.integer = $1.integer + $3.integer; 
				$$.type = 0;
			}
			if($1.type == 1) {
				$$.real = $1.real + $3.real; 
				$$.type = 1;
			}
		}
		else {
			yyerror("type mismatch on adding semantic error");
			$$.type = 1;
			if($1.type == 0)
				$$.real = $1.integer + $3.real;
			else
				$$.real = $1.real + $3.integer;
		}
   } 
   | exp _SUB term {
    		if($1.type == $3.type) {
			if($1.type == 0) {
    				$$.integer = $1.integer - $3.integer; 
				$$.type = 0;
			}
			if($1.type == 1) {
				$$.real = $1.real - $3.real; 
				$$.type = 1;
			}
		}
		else {
			yyerror("type mismatch on subtracting semantic error");
			$$.type = 1;
			if($1.type == 0)
				$$.real = $1.integer - $3.real;
			else
				$$.real = $1.real - $3.integer;
		}
   }  
   | term
   ;

term: term _MUL factor {
    		if($1.type == $3.type) {
			if($1.type == 0) {
    				$$.integer = $1.integer * $3.integer; 
				$$.type = 0;
			}
			if($1.type == 1) {
				$$.real = $1.real * $3.real; 
				$$.type = 1;
			}
		}
		else {
			yyerror("type mismatch on multiplication semantic error");
			$$.type = 1;
			if($1.type == 0)
				$$.real = $1.integer * $3.real;
			else
				$$.real = $1.real * $3.integer;
		}
    }
    | term _DIV factor { 
    		if($1.type == $3.type) {
			if($1.type == 0) {
    				$$.integer = $1.integer / $3.integer; 
				$$.type = 0;
			}
			if($1.type == 1) {
				$$.real = $1.real / $3.real; 
				$$.type = 1;
			}
		}
		else {
			yyerror("type mismatch on division semantic error");
			$$.type = 1;
			if($1.type == 0)
				$$.real = $1.integer / $3.real;
			else
				$$.real = $1.real / $3.integer;
		}
	}
    | factor
    ;

factor: _OPEN_BRACE exp _CLOSE_BRACE { $$ = $2; }
      | _INT { $$ = $1; }
      | _ID { 
      		if(is_declared($1)) {
			if(is_initialized($1)) {
				if(get_type($1) == 0) {
					$$.integer = get_int_value($1); 
					$$.type = 0;
				}
				if(get_type($1) == 1) {
					$$.real = get_real_value($1); 
					$$.type = 1;
				}
			}
			else {
				yyerror("variable not initialized semantic error");

				// not initialized so initialize to default values
				$$.integer = NOT_INIT; 
				$$.type = get_type($1);
			}
		}
		else {
			yyerror("missing declaration semantic error"); 

			// not declared so initialize to default values and give integer type
			$$.integer = NOT_INIT; 
			$$.type = 0;
		}
	}
      | _FLOAT { $$ = $1; }
      ;

read: _READ _OPEN_BRACE idlist _CLOSE_BRACE {
	if(!set_init())
		yyerror("missing declaration semantic error");

    }
    ;

write: _WRITE _OPEN_BRACE idlist _CLOSE_BRACE {
     	clear_list();
     }
     ;

for: _FOR indexexp _DO body
   ;

indexexp: _ID _ASSIGN exp _TO exp {
		if($3.type != $5.type) {
			yyerror("type mismatch on assignment semantic error");
		}
      		if(is_declared($1)) {
			if($3.type == get_type($1)) {
				if($3.type == 0) 
					set_int_value($1, $3.integer); 
				else if($3.type == 1)
					set_real_value($1, $3.real);
			}
			else 
				yyerror("type mismatch on assignment semantic error");// expression assignment mismatch
		}
		else
			yyerror("missing declaration semantic error");// error not declared symbol
		
	}
	;

body: _BEGIN stmtlist _END
    | stmt
    ;
%%
