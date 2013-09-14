/*******************************************************/
/*                     Cminus Parser                   */
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
Program		: Procedures 
		{
			// printf("<Program> -> <Procedures>\n");
		}
		| DeclList Procedures
		{
			// printf("<Program> -> <DeclList> <Procedures>\n");
		}
		  ;

Procedures 	: ProcedureDecl Procedures
		{
			// printf("<Procedures> -> <ProcedureDecl> <Procedures>\n");
		}
		|
		{
			// printf("<Procedures> -> epsilon\n");
		}
		;

ProcedureDecl : ProcedureHead ProcedureBody
		{
			// printf("<ProcedureDecl> -> <ProcedureHead> <ProcedureBody>\n");
		}
			  ;

ProcedureHead : FunctionDecl DeclList 
		{
			// printf("<ProcedureHead> -> <FunctionDecl> <DeclList>\n");
		}
		  | FunctionDecl
		{
			// printf("<ProcedureHead> -> <FunctionDecl>\n");
		}
			  ;

FunctionDecl :  Type IDENTIFIER LPAREN RPAREN LBRACE 
		{
			// printf("<FunctionDecl> ->  <Type> <IDENTIFIER> <LP> <RP> <LBR>\n"); 
		}
			;

ProcedureBody : StatementList RBRACE
		{
			// printf("<ProcedureBody> -> <StatementList> <RBR>\n");
		}
		  ;


DeclList 	: Type IdentifierList  SEMICOLON 
		{
			// printf("<DeclList> -> <Type> <IdentifierList> <SC>\n");
		}		
		| DeclList Type IdentifierList SEMICOLON
		{
			// printf("<DeclList> -> <DeclList> <Type> <IdentifierList> <SC>\n");
		}
			;


IdentifierList 	: VarDecl  
		{
			// printf("<IdentifierList> -> <VarDecl>\n");
		}
						
				| IdentifierList COMMA VarDecl
		{
			// printf("<IdentifierList> -> <IdentifierList> <CM> <VarDecl>\n");
		}
				;

VarDecl 	: IDENTIFIER
		{ 
			// printf("<VarDecl> -> <IDENTIFIER\n");
			if (SymFieldExists(table, $1)) {
				Cminus_error("Field already exists");
			}
			SymInitField(table, $1, NULL, NULL);
		}
		| IDENTIFIER LBRACKET INTCON RBRACKET
				{
			// printf("<VarDecl> -> <IDENTIFIER> <LBK> <INTCON> <RBK>\n");
		}
		;

Type     	: INTEGER 
		{ 
			// printf("<Type> -> <INTEGER>\n");
		}
				;

Statement 	: Assignment
		{ 
			// printf("<Statement> -> <Assignment>\n");
		}
				| IfStatement
		{ 
			// printf("<Statement> -> <IfStatement>\n");
		}
		| WhileStatement
		{ 
			// printf("<Statement> -> <WhileStatement>\n");
		}
				| IOStatement 
		{ 
			// printf("<Statement> -> <IOStatement>\n");
		}
		| ReturnStatement
		{ 
			// printf("<Statement> -> <ReturnStatement>\n");
		}
		| ExitStatement	
		{ 
			// printf("<Statement> -> <ExitStatement>\n");
		}
		| CompoundStatement
		{ 
			// printf("<Statement> -> <CompoundStatement>\n");
		}
				;

Assignment      : Variable ASSIGN Expr SEMICOLON
		{
			// printf("<Assignment = %d\n", $3);
			SymPutField(table, $1, $1, $3);
			// printf("<Assignment> -> <Variable> <ASSIGN> <Expr> <SC>\n");
		}
				;
				
IfStatement	: IF TestAndThen ELSE CompoundStatement
		{
			// printf("<IfStatement> -> <IF> <TestAndThen> <ELSE> <CompoundStatement>\n");
		}
		| IF TestAndThen
		{
			// printf("<IfStatement> -> <IF> <TestAndThen>\n");
		}
		;
		
				
TestAndThen	: Test CompoundStatement
		{
			// printf("<TestAndThen> -> <Test> <CompoundStatement>\n");
		}
		;
				
Test		: LPAREN Expr RPAREN
		{
			// printf("<Test> -> <LP> <Expr> <RP>\n");
			$$ = $2
		}
		;
	

WhileStatement  : WhileToken WhileExpr Statement
		{
			// printf("<WhileStatement> -> <WhileToken> <WhileExpr> <Statement>\n");
		}
				;
				
WhileExpr	: LPAREN Expr RPAREN
		{
			// printf("<WhileExpr> -> <LP> <Expr> <RP>\n");
		}
		;
				
WhileToken	: WHILE
		{
			// printf("<WhileToken> -> <WHILE>\n");
		}
		;


IOStatement : 
	READ LPAREN Variable RPAREN SEMICOLON {
		// printf("<IOStatement> -> <READ> <LP> <Variable> <RP> <SC>\n");
		printf("%d\n", SymGetField(table, $3, $3));
	}

	| WRITE LPAREN Expr RPAREN SEMICOLON {
		// printf("<IOStatement> -> <WRITE> <LP> <Expr> <RP> <SC>\n");
		printf("%d\n", $3);
	}

	| WRITE LPAREN StringConstant RPAREN SEMICOLON {
		printf("%s\n", $3);
		// printf("<IOStatement> -> <WRITE> <LP> <StringConstant> <RP> <SC>\n");
	}
;

ReturnStatement : RETURN Expr SEMICOLON
		{
			// printf("<ReturnStatement> -> <RETURN> <Expr> <SC>\n");
		}
				;

ExitStatement 	: EXIT SEMICOLON
		{
			exit(0);
			// printf("<ExitStatement> -> <EXIT> <SC>\n");
		}
		;

CompoundStatement : LBRACE StatementList RBRACE
		{
			// printf("<CompoundStatement> -> <LBR> <StatementList> <RBR>\n");
		}
				;

StatementList   : Statement
		{		
			// printf("<StatementList> -> <Statement>\n");
		}
				| StatementList Statement
		{		
			// printf("<StatementList> -> <StatementList> <Statement>\n");
		}
				;

Expr            : SimpleExpr
		{
			// printf("<Expr> -> <SimpleExpr>\n");
			$$ = $1; // TODO
		}
				| Expr OR SimpleExpr 
		{
			// printf("<Expr> -> <Expr> <OR> <SimpleExpr> \n");
			$$ = $1 || $3;
		}
				| Expr AND SimpleExpr 
		{
			// printf("<Expr> -> <Expr> <AND> <SimpleExpr> \n");
			$$ = $1 && $3;
		}
				| NOT SimpleExpr 
		{
			// printf("<Expr> -> <NOT> <SimpleExpr> \n");
			$$ = ($2 == 0) ? 1 : 0;
		}
				;

SimpleExpr	: AddExpr
		{
			// printf("<SimpleExpr> -> <AddExpr>\n");
			$$ = $1; // TODO
		}
				| SimpleExpr EQ AddExpr
		{
			// printf("<SimpleExpr> -> <SimpleExpr> <EQ> <AddExpr> \n");
			$$ = ($1 == $3) ? 1 : 0;
		}
				| SimpleExpr NE AddExpr
		{
			// printf("<SimpleExpr> -> <SimpleExpr> <NE> <AddExpr> \n");
			$$ = ($1 == $3) ? 0 : 1;
		}
				| SimpleExpr LE AddExpr
		{
			// printf("<SimpleExpr> -> <SimpleExpr> <LE> <AddExpr> \n");
			$$ = ($1 <= $3) ? 1 : 0;
		}
				| SimpleExpr LT AddExpr
		{
			// printf("<SimpleExpr> -> <SimpleExpr> <LT> <AddExpr> \n");
			$$ = ($1 < $3) ? 1 : 0;
		}
				| SimpleExpr GE AddExpr
		{
			// printf("<SimpleExpr> -> <SimpleExpr> <GE> <AddExpr> \n");
			$$ = ($1 >= $3) ? 1 : 0;
		}
				| SimpleExpr GT AddExpr
		{
			// printf("<SimpleExpr> -> <SimpleExpr> <GT> <AddExpr> \n");
			$$ = ($1 > $3) ? 1 : 0;
		}
				;

AddExpr	: 
	MulExpr {
		$$ = $1; // TODO
		// printf("string is %s\n", $1);
		// printf("<AddExpr> -> <MulExpr>\n");
	}
	| AddExpr PLUS MulExpr {
		$$ = $1 + $3;
		// printf("<Added %d + %d\n", $1, $3);
		// printf("<AddExpr..> -> <AddExpr> <PLUS> <MulExpr> \n");
	}
	| AddExpr MINUS MulExpr {
		$$ = $1 - $3;
		// printf("<AddExpr> -> <AddExpr> <MINUS> <MulExpr> \n");
	}
;

MulExpr : 
	Factor {
		// printf("<MulExpr> -> <Factor>\n");
		$$ = $1;
		// printf("string is %s\n", $1);
	}
	|  MulExpr TIMES Factor {
		// printf("<MulExpr> -> <MulExpr> <TIMES> <Factor> \n");
		$$ = $1 * $3;
	}
	|  MulExpr DIVIDE Factor {
		// printf("<MulExpr> -> <MulExpr> <DIVIDE> <Factor> \n");
		$$ = $1 / $3;
	}		
				;
				
Factor          : Variable
		{ 
			// printf("<Factor> -> <Variable>\n");
			// printf("<string is %s\n", $1);
			$$ = SymGetField(table, $1, $1)
		}
				| Constant
		{ 
			// printf("<Factor> -> <Constant>\n");
			$$ = $1;
		}
				| IDENTIFIER LPAREN RPAREN
			{	
				// this is a function call
			// printf("<Factor> -> <IDENTIFIER> <LP> <RP>\n");
			$$ = $1;
		}
			| LPAREN Expr RPAREN
		{
			// printf("<Factor> -> <LP> <Expr> <RP>\n");
			$$ = $2;
		}
				;  

Variable : 
	IDENTIFIER {
		// printf("<string is %s\n", $1);
		$$ = $1;
		// printf("<Variable> -> <IDENTIFIER>\n");
	}
	| IDENTIFIER LBRACKET Expr RBRACKET {
		$$ = $1;
		// printf("<Variable> -> <IDENTIFIER> <LBK> <Expr> <RBK>\n");
	}
;

StringConstant : 
	STRING { 
		char* rv = $1;
		rv++;
		rv[strlen(rv)-1] = 0;
		$$ = rv;
	}
;

Constant : 
	INTCON { 
		$$ = $1;
	}
;

%%


/********************C ROUTINES *********************************/

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
