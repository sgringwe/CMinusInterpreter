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
#define SYMTAB_VALUE_FIELD     "value"

/*********************EXTERNAL DECLARATIONS***********************/

EXTERN(void,Cminus_error,(char*));

EXTERN(int,Cminus_lex,(void));

char *fileName;

extern int Cminus_lineno;

SymTable table;

%}

%name-prefix="Cminus_"
%defines

%token AND
%token ELSE
%token EXIT
%token FOR
%token IF 		
%token INTEGER 
%token NOT 		
%token OR 		
%token READ
%token WHILE
%token WRITE
%token LBRACE
%token RBRACE
%token LE
%token LT
%token GE
%token GT
%token EQ
%token NE
%token ASSIGN
%token COMMA
%token SEMICOLON
%token LBRACKET
%token RBRACKET
%token LPAREN
%token RPAREN
%token PLUS
%token TIMES
%token IDENTIFIER
%token DIVIDE
%token RETURN
%token STRING	
%token INTCON
%token MINUS

%left OR
%left AND
%left NOT
%left LT LE GT GE NE EQ
%left PLUS MINUS
%left TIMES DIVDE
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

VarDecl : 
	IDENTIFIER
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
		setValue($1, $3);
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
	LPAREN Expr RPAREN
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
		//printf("%d\n", getValue($3)); // Get variable value and print it
	}
	| WRITE LPAREN Expr RPAREN SEMICOLON {
		printf("%d\n", $3); // Print the outcome of the expression
	}
	| WRITE LPAREN StringConstant RPAREN SEMICOLON {
		printf("%s\n", (char *)SymGetFieldByIndex(table, $3, SYM_NAME_FIELD)); // Print the string constant
	}
;

ReturnStatement : 
	RETURN Expr SEMICOLON
		
;

ExitStatement 
	: EXIT SEMICOLON
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
		$$ = getValue($1);
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
		$$ = $1;
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
	SymInitField(table,SYMTAB_VALUE_FIELD,(Generic)-1,NULL);
}

static void finalize() {
	SymKillField(table,SYMTAB_VALUE_FIELD);
  SymKill(table);
	fclose(stdin);
	fclose(stdout);
}

int getValue(int index) {
  return (int)SymGetFieldByIndex(table, index, SYMTAB_VALUE_FIELD); 
}

int setValue(int index, int value) {
  SymPutFieldByIndex(table, index, SYMTAB_VALUE_FIELD, (Generic)value); 
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
