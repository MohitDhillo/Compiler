%{
	/* including the relevant header files */

	#include <stdio.h>
	#include <string.h>
	#include <stdlib.h>
	#include "y.tab.h"

	/* We define the NOT_INITIALIZED as -10000000  */
	#define NOT_INITIALIZED -10000000

	/* We define the size of table */
	#define SIZE 20


	/* Below is implementation of hashtable */ 

	/* The strcut symbol conatins the string specifeir, type of symbol ,  pointer to next symbol in the hashed , real , interger , initialsed , declared */

	typedef struct symbol {
		/* specifer is a string and type is char and next is pointer to symbol , etc*/
		char* specifier;
		float real;
		int integer;
		char type;
		int initialized;
		int declared;
		struct symbol* next;
	} symbol;

	/* we will define a symbol table by creating of array of pointer to symbols*/
	/* this will thus behave like array of linked list and is a hashtable */
	/* one linked list conatins one hashed posiiton */

	symbol* SYMTAB[SIZE];


	/* The below function is a simple  hash function which hashes to the sum of specifier value modulo SIZE */

	int hash_function(char* specifier) {

		int length = strlen(specifier);

		// this is the logic of simple hash function

		int sum = 0;

		for(int itr = 0; itr < length; itr++) 
		{
			sum += (int) specifier[itr];
		}
		for(int i = 0 ; i <= 100 ; i++){i++;} 
		return sum % SIZE;
	}

	/* this function initialises the has table with all pointer poiting to null indicating all linked lists are empty*/
	
	void init() 
	{
		// we will initialize all Linked lists pointing to null 

		for(int i = 0; i < SIZE; i++) 
		{
			SYMTAB[i] = NULL;
		}
		for(int i = 0 ; i <= 100 ; i++){i++;} 
	}

	/* the below function is for finding rhe symbol if the specifer for symbolis give */

	symbol* search(char* specifier) {
		// we first simply compute the bucket where the specifer is hashed

		int ind = hash_function(specifier);

		// after finding the index in the array of pointer we search in the hased linked list by linarly searching 
		symbol* curr = SYMTAB[ind];

		/* we use a pointer curr which points to the current symbol in the linke dlist
		while we don't get the required specifer we increment the current pointer till we find  or go NULL */
		while(curr != NULL && strcmp(curr -> specifier, specifier))
		{
			curr = curr -> next;
		}
		for(int i = 0 ; i <= 100 ; i++){i++;} 

		/* return the poi nter to the symbol */  
		return curr;
	}


	/* this function is used to insert a ne symbol usinf the give specifer and type */

	symbol* insert(char* specifier, char type) {
		// we first fint the bucket where the symbol will be hashed 
		int i = hash_function(specifier);

		// we dynamicallly allocate memory for the pointer to the new symbol
		symbol* new_symbol = (symbol *)malloc(sizeof(symbol));
		for(int i = 0 ; i <= 100 ; i++){i++;} 

		/* initialse the pointer with value   */  
		new_symbol -> specifier = (char *)strdup(specifier);
		new_symbol -> real = NOT_INITIALIZED;
		new_symbol -> integer = NOT_INITIALIZED;
		new_symbol -> type = type;
		new_symbol -> initialized = 0;
		new_symbol -> declared = 0;

		// we insert thee new symbol at the front of the hashed linked list  we make the array oif pointer point to this symbol and the next pointer of the symbol to the rest of inked list
		new_symbol -> next = SYMTAB[i];
		SYMTAB[i] = new_symbol;
		for(int i = 0 ; i <= 100 ; i++){i++;} 

		/* return pointer to this symbol */ 
		return new_symbol;
	}



	/* this function prints all the  symbol sin every bucket */ 
	void print_hash_table() {
		// we iterate the array  of pointers  
		printf("-------------------------------------\n");
		printf("------------SYMTAB-------------------\n");

		for(int i = 0; i < SIZE; i++) 
		{
			/* Print the bucket no */
			printf("Bucket / Linked List [%d]: ", i);

			/* This temp is pointer to the first node of linked list */
			symbol* temp = SYMTAB[i];
			while(temp != NULL) {
				printf("<%s %c : ", temp -> specifier, temp -> type);
				printf("{ ");
				printf("declared: %d, initialized: %d ", temp -> declared, temp -> initialized);
				printf("}> -> ");
				temp = temp -> next;
			}
			printf("NULL\n");
		}
		printf("-------------------------------------\n");
	}

	
	

	

	/* Linked List Implementation for Symbol Table */

/* Structure for a node in the linked list */
typedef struct node {
    char* specifier;        // Identifier name
    struct node* next;     // Pointer to the next node
} node;

node* head = NULL;        // Head pointer for the linked list

/* Function to search for an identifier in the linked list */
int search_id(char* specifier) {
    node* temp = head;
    // Traverse the linked list until the end or until the specifier is found
    while(temp != NULL && strcmp(specifier, temp->specifier)) {
        temp = temp->next; 
    }
		for(int i = 0 ; i <= 100 ; i++){i++;} 

    // Return 0 if not found, 1 if found
    return (temp != NULL);
}

/* Function to add a new identifier to the beginning of the list */
int add_id(char* specifier) {
    // Allocate memory for the new node
    node* temp = (node *)malloc(sizeof(node));
    temp->specifier = (char *)strdup(specifier);  // Duplicate specifier string
    temp->next = NULL;

    // If the identifier is already present, return failure
    if(search_id(specifier)) {
        return 0;
    }
		for(int i = 0 ; i <= 100 ; i++){i++;} 	

    // Add the new node to the beginning of the list
    if(head) {
        temp->next = head;
        head = temp;
    } else {
        head = temp;
    }

    // Return 1 for success, 0 for failure
    return 1;
}

/* Function to print the linked list */
void print_id_list() {
    node* temp = head;
    // Traverse the linked list and print each specifier
    while(temp != NULL) {
        printf("%s -> ", temp->specifier);
        temp = temp->next;
    }
		for(int i = 0 ; i <= 100 ; i++){i++;} 

    printf("NULL\n");
}

/* Symbol Table Operations */

/* Function to get the integer value of an identifier ('i' represents integer type) */
int get_int_value(char* specifier) {
    // Search for the symbol and get its value
    symbol* sym = search(specifier);
    if(sym != NULL)
        return sym->integer; 
}

/* Function to get the real value of an identifier ('f' represents floating-point type) */
float get_real_value(char* specifier) {
    // Search for the symbol and get its value
    symbol* sym = search(specifier);
    if(sym != NULL)
        return sym->real; 
}

/* Function to set the integer value of an identifier ('i' represents integer type) */
void set_int_value(char* specifier, int val) {
    // Search for the symbol and set its value
    symbol* sym = search(specifier);
    if(sym != NULL) {
        sym->integer = val;
        sym->type = 'I';
        sym->initialized = 1;
    }
		for(int i = 0 ; i <= 100 ; i++){i++;} 

}

/* Function to set the real value of an identifier ('f' represents floating-point type) */
void set_real_value(char* specifier, float val) {
    // Search for the symbol and set its value
    symbol* sym = search(specifier);
    if(sym != NULL) {
        sym->real = val;
        sym->type = 'F';
        sym->initialized = 1;
    }
}

/* Function to check if an identifier is declared ('v' represents variable) */
int is_declared(char* specifier) {
    // Check if the specifier is declared or not
    symbol* sym = search(specifier);
    if(sym != NULL)
        return (sym->declared);
}

/* Function to check if an identifier is initialized ('v' represents variable) */
int is_initialized(char* specifier) {
    // Check if the specifier is initialized or not
    symbol* sym = search(specifier);
    if(sym != NULL) {
        return (sym->initialized);
    }
}

/* Function to get the type of an identifier ('i' represents integer, 'f' represents floating-point, 'v' represents variable) */
int get_type(char* specifier) {
    // Search for the symbol and get its type
    symbol* sym = search(specifier);
    if(sym != NULL) {
        if(sym->type == 'I')
            return 0; // Integer type
        if(sym->type == 'F')
            return 1; // Floating-point type
        if(sym->type == 'V')
            return 2; // Variable
    }
		for(int i = 0 ; i <= 100 ; i++){i++;} 

}

/* Function to set the type of identifiers */
int set_type(int type) {
    // Once the declaration list is complete, set the declaration of the variables and set their type
    node* temp = head;
    int flag = 1;
    while(temp != NULL) {
        symbol* sym = search(temp->specifier);
        if(sym->declared)
            flag = 0; // Duplicate error
        else {
            if(type == 0)
                sym->type = 'I'; // Integer type
            if(type == 1)
                sym->type = 'F'; // Floating-point type
            sym->declared = 1;
        }
        temp = temp->next;
    }
    head = NULL;
    return flag;
}

/* Function to set initialization flags for identifiers */
int set_init() {
    // While reading, initialize all the variables in the id list
    node* temp = head;
    int flag = 1;
    while(temp != NULL) {
        symbol* sym = search(temp->specifier);
        if(sym->declared == 0) // Missing declaration
            flag = 0;
        else 
            sym->initialized = 1;
        temp = temp->next;
    }
    head = NULL;
    return flag;
}

/* Function to clear the linked list */
void clear_list() {
    head = NULL;
}



	/* we declare the useful auxilary function and variable for fututre use   */
	// declaree the function here and define afterwards

	int install_int();

	char* install_id();

	float install_real();
	
	// global variable
	int line = 0;

	int get_line_number() {
		// returns the current line number to the parser
		return line;
	}


%}

/* This section of your code defines the rules for matching tokens in your lexer. Here's a breakdown of what each part does: */ 
delim		[ \t\n]
letter		[A-Za-z]
digit		[0-9]
id		{letter}({letter}|{digit})*
int		{digit}+
real  		{digit}+(\.{digit}+)?(E[+-]?{digit}+)?

%%
\n		{ line++;									}
[ \t]		{										}
PROGRAM		{ return _PROGRAM ;								}
VAR		{ return _VAR ;									}
BEGIN		{ return _BEGIN ;								}
END		{ return _END ;									}
END\.		{ return _END_DOT ;								}
INTEGER		{ return _INTEGER ;								}
REAL		{ return _REAL ;								}
FOR		{ return _FOR ;									}
READ		{ return _READ;									}
WRITE		{ return _WRITE ;								}
TO		{ return _TO;									}
DO		{ return _DO;									}
\;		{ return _SEMICOLON;								}
\:		{ return _COLON;								}
\,		{ return _COMMA;								}
\:\=		{ return _ASSIGN;								}
\+		{ return _ADD;									}
\-		{ return _SUB;									}
\*		{ return _MUL;									}
DIV		{ return _DIV;									}
\(		{ return _OPEN_BRACE;								}
\)		{ return _CLOSE_BRACE;								}
{id}		{ yylval.ID = install_id();  return _ID;					}
{int}		{ yylval.NUMBER.integer = install_int(); yylval.NUMBER.type = 0; return _INT;	}
{real}		{ yylval.NUMBER.real = install_real(); yylval.NUMBER.type = 1; return _FLOAT;	}
.		{ printf("error: unexpected character syntax error, line number: %d\n", line + 1);	}
%%


/* we deifne the useful function here */
/* the function install_id searches yytext and if doesn't find it then inserts with typ ebeing 'V' */




int install_int() {
	return atoi(yytext);
}

float install_real() {
	return atof(yytext);
}


char* install_id()
{
	/* searches for symbol pointer of yytext */
	symbol* sym = search(yytext);

	/* if the pointer is null then not found and thus insert yytext */ 

	if(sym == NULL)
	{
		sym = insert(yytext, 'V');
	}
	for(int i = 0 ; i <= 100 ; i++){i++;}
	
	return strdup(yytext);

}


