/*******************************************************/
/*                     Cminus Parser                   */
/* Student: Scott Ringwelski
/* Program: CMinusProject1
/* An interpreter for the CMinus language
/*                                                     */
/*******************************************************/

/*********************DEFINITIONS***********************/
%{
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <string.h>
#include <util/general.h>
#include <util/symtab.h>
#include <util/symtab_stack.h>
#include <util/dlink.h>
#include <util/string_utils.h>

#define SYMTABLE_SIZE 100

/*********************EXTERNAL DECLARATIONS***********************/

EXTERN(void,Cminus_error,(char*));

EXTERN(int,Cminus_lex,(void));

char *fileName;

extern int Cminus_lineno;

SymTable table;

%}

%name-prefix="Cminus_"
%defines

%token<i> AND
%token ELSE
%token EXIT
%token FOR
%token<i> IF 		
%token<i> INTEGER 
%token<i> NOT 		
%token<i> OR 		
%token READ
%token WHILE
%token WRITE
%token LBRACE
%token RBRACE
%token<i> LE
%token<i> LT
%token<i> GE
%token<i> GT
%token<i> EQ
%token<i> NE
%token<i> ASSIGN
%token COMMA
%token SEMICOLON
%token LBRACKET
%token RBRACKET
%token LPAREN
%token RPAREN
%token<i> PLUS
%token<i> TIMES
%token<s> IDENTIFIER
%token<i> DIVIDE
%token RETURN
%token<s> STRING	
%token<s> INTCON
%token<i> MINUS

%type<s> StringConstant IOStatement Variable
%type<i> Constant Test Factor AddExpr MulExpr SimpleExpr Expr Assignment

%left OR
%left AND
%left NOT
%left LT LE GT GE NE EQ
%left PLUS MINUS
%left TIMES DIVDE

%union {
  int i;
  char* s;
}

%start Program

/***********************PRODUCTIONS****************************/
%%
Program	: 
	Procedures
	| DeclList Procedures
;

Procedures 	: 
	ProcedureDecl Procedures 
	| 
;

ProcedureDecl : 
	ProcedureHead ProcedureBody 
;

ProcedureHead : 
	FunctionDecl DeclList 
	| FunctionDecl 
;

FunctionDecl :  
	Type IDENTIFIER LPAREN RPAREN LBRACE 
;

ProcedureBody : 
	StatementList RBRACE 
;


DeclList : 
	Type IdentifierList  SEMICOLON 		
	| DeclList Type IdentifierList SEMICOLON
		
;


IdentifierList : 
	VarDecl 
	| IdentifierList COMMA VarDecl 
;

// When a variable is declared, initialize it in the symbol table.
// The variable can then be accessed later
VarDecl : 
	IDENTIFIER { 
		if (SymFieldExists(table, $1)) {
			Cminus_error("Field already exists");
		}
		SymInitField(table, $1, NULL, NULL);
	}
	| IDENTIFIER LBRACKET INTCON RBRACKET 
;

Type : 
	INTEGER 
;

Statement : 
	Assignment 
	| IfStatement
	| WhileStatement
	| IOStatement 
	| ReturnStatement
	| ExitStatement	
	| CompoundStatement
;

// When an assignment is done, update the symbol table field.
// First check if the field exists and reprot an error if it doesn't
Assignment : 
	Variable ASSIGN Expr SEMICOLON {
		checkFieldExists($1);
		SymPutField(table, $1, $1, $3);
	}
;
				
IfStatement	: 
	IF TestAndThen ELSE CompoundStatement 
	| IF TestAndThen 
;
		
				
TestAndThen	: 
	Test CompoundStatement 
;
				
Test : 
	LPAREN Expr RPAREN {
		$$ = $2;
	}
;
	

WhileStatement : 
	WhileToken WhileExpr Statement 
;
				
WhileExpr : 
	LPAREN Expr RPAREN 
;
				
WhileToken : 
	WHILE 
;

// This is where content is printed. It will either be an integer (first 2 cases) or
// a string constant
IOStatement : 
	READ LPAREN Variable RPAREN SEMICOLON {
		checkFieldExists($3);
		printf("%d\n", SymGetField(table, $3, $3)); // Get variable value and print it
	}
	| WRITE LPAREN Expr RPAREN SEMICOLON {
		printf("%d\n", $3); // Print the outcome of the expression
	}
	| WRITE LPAREN StringConstant RPAREN SEMICOLON {
		printf("%s\n", $3); // Print the string constant
	}
;

ReturnStatement : 
	RETURN Expr SEMICOLON
		
;

ExitStatement 
	: EXIT SEMICOLON {
		exit(0);
	}
;

CompoundStatement : 
	LBRACE StatementList RBRACE 
;

StatementList : 
	Statement 
	| StatementList Statement 
;

// Straight forward translation
Expr : 
	SimpleExpr {
		$$ = $1;
	}
	| Expr OR SimpleExpr {
		$$ = $1 || $3;
	}
	| Expr AND SimpleExpr {
		$$ = $1 && $3;
	}
	| NOT SimpleExpr {
		$$ = ($2 == 0) ? 1 : 0;
	}
;

// Straightforward translation
SimpleExpr : 
	AddExpr {
		$$ = $1;
	}
	| SimpleExpr EQ AddExpr {
		$$ = ($1 == $3) ? 1 : 0;
	}
	| SimpleExpr NE AddExpr {
		$$ = ($1 == $3) ? 0 : 1;
	}
	| SimpleExpr LE AddExpr {
		$$ = ($1 <= $3) ? 1 : 0;
	}
	| SimpleExpr LT AddExpr {
		$$ = ($1 < $3) ? 1 : 0;
	}
	| SimpleExpr GE AddExpr {
		$$ = ($1 >= $3) ? 1 : 0;
	}
	| SimpleExpr GT AddExpr {
		$$ = ($1 > $3) ? 1 : 0;
	}
;

// Addition expression
AddExpr	: 
	MulExpr {
		$$ = $1;
	}
	| AddExpr PLUS MulExpr {
		$$ = $1 + $3;
	}
	| AddExpr MINUS MulExpr {
		$$ = $1 - $3;
	}
;

// Multiple Expression
MulExpr : 
	Factor {
		$$ = $1;
	}
	|  MulExpr TIMES Factor {
		$$ = $1 * $3;
	}
	|  MulExpr DIVIDE Factor {
		$$ = $1 / $3;
	}		
;

// For variables, look up the value and return it.
// For constants, function calls and parenthesised expressions, return the value 
Factor : 
	Variable { 
		$$ = SymGetField(table, $1, $1);
	}
	| Constant { 
		$$ = $1;
	}
	| IDENTIFIER LPAREN RPAREN {
		$$ = $1;
	}
	| LPAREN Expr RPAREN {
		$$ = $2;
	}
;  

// Either a variable or function.
Variable : 
	IDENTIFIER {
		$$ = $1;
	}
	| IDENTIFIER LBRACKET Expr RBRACKET {
		$$ = $1;
	}
;

// String constants include the ''s when passed from flex. Remove those and then return the string.
StringConstant : 
	STRING {
		// This removes the '' from the string that was parsed.
		char* rv = $1;
		rv++;
		rv[strlen(rv)-1] = 0;
		$$ = rv;
	}
;

// Simply return the integer for now (only variable type)
Constant : 
	INTCON { 
		$$ = $1;
	}
;

%%


/********************C ROUTINES *********************************/

// Checks if a field exists and if it does not, calls a Cminus_error
void checkFieldExists(char *s)
{
	if (!SymFieldExists(table, s)) {
		Cminus_error("Undefined reference\n");
	}
}

// Prints out an error with file/line/cursor position.
void Cminus_error(char *s)
{
  fprintf(stderr,"%s: line %d: %s\n",fileName,Cminus_lineno,s);
}

int Cminus_wrap() {
	return 1;
}

static void initialize(char* inputFileName) {

	stdin = freopen(inputFileName,"r",stdin);
		if (stdin == NULL) {
		  fprintf(stderr,"Error: Could not open file %s\n",inputFileName);
		  exit(-1);
		}

	char* dotChar = rindex(inputFileName,'.');
	int endIndex = strlen(inputFileName) - strlen(dotChar);
	char *outputFileName = nssave(2,substr(inputFileName,0,endIndex),".s");
	stdout = freopen(outputFileName,"w",stdout);
		if (stdout == NULL) {
		  fprintf(stderr,"Error: Could not open file %s\n",outputFileName);
		  exit(-1);
		}

	// Initialize the symbol table
	table = SymInit(SYMTABLE_SIZE);

}

static void finalize() {

	fclose(stdin);
	fclose(stdout);
	

}

int main(int argc, char** argv)

{	
	fileName = argv[1];
	initialize(fileName);
	
		Cminus_parse();
  
	finalize();
  
	return 0;
}
/******************END OF C ROUTINES**********************/
