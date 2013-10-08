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

// Register management
int REGISTER_COUNT = 13;
char *register_names[13] = { "%eax", "%ebx", "%ecx", "%edx", "%esi", "%edi", "%r8d", "%r9d", "%r10d", "%r11d", "%r12d", "%r13d", "%r14d", "%r15d" };
int register_taken[13]; // 1 for true

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
		// save in the symbol table the:
		// name
		// type (always int for now)
		// offset
		setValue($1, var_count * 4);
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
	// Example code:
	// movq $_gp,%rbx
  // addq $4, %rbx
  // movl $.int_rformat, %edi
  // movl %ebx, %esi
  // movl $0, %eax
  // call scanf
	//
	// $3 represents register id holding memory address of variable to print
	READ LPAREN Variable RPAREN SEMICOLON {
		buffer("movq $_gp,%rbx\n");
    buffer("addq $4, %rbx\n");
    buffer("movl $.int_rformat, %edi\n");
    buffer("movl %ebx, %esi\n");
    buffer("movl $0, %eax\n");
    buffer("call scanf\n");
	}

	// Example code:
	// movl $7, %ebx
	// movl %ebx, %esi
	// movl $0, %eax
	// movl $.int_wformat, %edi
	// call printf
	//
	// $3 represents register id holding the memory address of variable to print
	| WRITE LPAREN Expr RPAREN SEMICOLON {
		int reg1 = allocateRegister();
		int reg2 = allocateRegister();
		int reg3 = allocateRegister();
		int reg4 = allocateRegister();

		char temp[80];

		// possible issues with this: is %edi and %esi reserved? where does printf look for printing variables
		emit("movl", register_names[$3], register_names[reg1]); // first reg may need () around it
		emit("movl", register_names[reg1], register_names[reg2]); // move result into reg2
		emit("movl", "$0", register_names[reg3]); // set reg3 to be 0
		emit("movl", "$.int_wformat", register_names[reg4]); // set reg4 to be address of $.int_wformat
		buffer("call printf\n"); // call printf

		freeRegister(reg1);
		freeRegister(reg2);
		freeRegister(reg3);
		freeRegister(reg4);

		// sprintf(temp, "$%d", )


		// sprintf(temp, "movl %ds, %%ebx\n", register_names[$3]);
		// buffer(temp);

  //   buffer("movl %ebx, %esi\n");
  //   buffer("movl $0, %eax\n");
  //   buffer("movl $.int_wformat, %edi\n");
  //   buffer("call printf\n");
	}
	| WRITE LPAREN StringConstant RPAREN SEMICOLON {
		sprintf(printfs, "%s.string_const%d:	.string	\"%s\"\n", printfs, str_const_count, (char *)SymGetFieldByIndex(table, $3, SYM_NAME_FIELD)); // TODO: escape stuff out of $3
		
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
		getValue($1);
		buffer("movq $_gp,%rbx\n");

		char temp[80];
		sprintf(temp, "addq $%d, %rbx\n", $1);
		buffer(temp);

    buffer("movl (%rbx), %eax");
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
		int offset = getOffset($1);

		int reg = loadFromMemory(offset);

		$$ = reg;
	}
	| IDENTIFIER LBRACKET Expr RBRACKET {
		$$ = $1;
	}
;

// Just pass the string. We will buffer the printf for the header and buffer the actual printf
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

int getOffset(int index) {
	return (int)SymGetFieldByIndex(table, index, SYMTAB_VALUE_FIELD);
}

// Returns the index of the register we are using. Index maps to register_names
int allocateRegister() {
	int i = 0;
	for(i = 0; i < REGISTER_COUNT; ++i) {
		if(register_taken[i] == 0) {
			register_taken[i] = 1;
			return i;
		}
	}

	Cminus_error("No registers remaining for allocation.");
	return -1;
}

// loads variable from memory at the given offset into a register
//
// Example:
// movq $_gp,%rbx
// addq $4, %rbx
// movl (%rbx), %eax
int loadFromMemory(int offset) {
	int reg1 = allocateRegister();
	int reg2 = allocateRegister();

	char temp[80];
	sprintf(temp, "$%d", offset);

	emit("movq", "$_gp", register_names[reg1]); // set %rbx reg to equal _gp

	sprintf(temp, "$%d", offset);
	emit("addq", temp, register_names[reg1]); // add offset to %rbx to move to correct memory location for variable

	sprintf(temp, "(%s)", register_names[reg1]);
	emit("movl", temp, register_names[reg2]); // store the memory location of rbx in eax

	freeRegister(reg1);

	return reg2; // reg2 now holds the location of the variable we want
}

void freeRegister(int index) {
	register_taken[index] = 0;
}

void emit(char *instruction, char *one, char *two) {
	char temp[80];
	sprintf(temp, "%s %s, %s\n", instruction, one, two);
	buffer(temp);
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

void setValue(int index, int value) {
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
