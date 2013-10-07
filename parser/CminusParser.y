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

const char *ASSEMBLY_HEADER =
"	.section        .rodata\n";

const char *BASIC_PRINTFS =
".int_wformat: .string \"%d\\n\"\n"
".str_wformat: .string \"%s\\n\"\n"
".int_rformat: .string \"%d\"\n";

const char *OTHER = 
"	.text\n"
"	.globl main\n"
"	.type main,@function\n"
"main:   nop\n"
"	pushq %rbp\n"
"	movq %rsp, %rbp\n";

const char *ASSEMBLY_FOOTER =
"	leave\n"
"	ret\n";

extern int Cminus_lineno;

SymTable table;
int var_count;
int str_const_count;
char statements[99999]; // TODO: FIX
char printfs[9999]; // List of printf options

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
	Type IdentifierList SEMICOLON 		
	| DeclList Type IdentifierList SEMICOLON
		
;


IdentifierList : 
	VarDecl 
	| IdentifierList COMMA VarDecl 
;

VarDecl : 
	IDENTIFIER {
		++var_count;
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
		// setValue($1, $3);
		buffer("movq $_gp,%rbx\n");
    buffer("addq $0, %rbx\n");

    // printf("movl $5, %ecx\n");

    char temp[80];
		sprintf(temp, "movl $%d, %%ecx\n", $3);
		buffer(temp);

    buffer("movl %ecx, (%rbx)\n");
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
		buffer("movq $_gp,%rbx\n");
    buffer("addq $4, %rbx\n");
    buffer("movl $.int_rformat, %edi\n");
    buffer("movl %ebx, %esi\n");
    buffer("movl $0, %eax\n");
    buffer("call scanf\n");
	}
	| WRITE LPAREN Expr RPAREN SEMICOLON {
		char temp[80];
		sprintf(temp, "movl $%d, %%ebx\n", $3);
		buffer(temp);

    buffer("movl %ebx, %esi\n");
    buffer("movl $0, %eax\n");
    buffer("movl $.int_wformat, %edi\n");
    buffer("call printf\n");
	}
	| WRITE LPAREN StringConstant RPAREN SEMICOLON {
		sprintf(printfs, "%s.string_const%d:	.string	\"%s\"\n", printfs, str_const_count, (char *)SymGetFieldByIndex(table,$3, SYM_NAME_FIELD)); // TODO: escape stuff out of $3
		
		char temp[80];
		sprintf(temp, "movl $.string_const%d, %%ebx\n", str_const_count);
		buffer(temp);
		//printf("movl %s, %ebx\n", constant_name); // TODO: USE THIS

    buffer("movl %ebx, %esi\n");
    buffer("movl $0, %eax\n");
    buffer("movl $.str_wformat, %edi\n"); // TODO: Pick correct string constant
    buffer("call printf\n");

		++str_const_count;
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

	// We keep track of variable count for header global data declaration
	var_count = 0;
	str_const_count = 0;

	// Print out the initial header every file has
	printf("%s", ASSEMBLY_HEADER);
	printf("%s", BASIC_PRINTFS);

	// Initialize the symbol table
	table = SymInit(SYMTABLE_SIZE);
	SymInitField(table,SYMTAB_VALUE_FIELD,(Generic)-1,NULL);
}

static void finalize() {
	printf("%s", printfs);
	printf("	.comm _gp, %d, 4\n", var_count * 4);
	printf("%s", OTHER);
	printf("%s", statements);
	printf("%s", ASSEMBLY_FOOTER);

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

void buffer(char *add) {
	sprintf(statements, "%s	%s", statements, add);
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
