<Type> -> <INTEGER>
<FunctionDecl> ->  <Type> <IDENTIFIER> <LP> <RP> <LBR>
<Type> -> <INTEGER>
<VarDecl> -> <IDENTIFIER
<IdentifierList> -> <VarDecl>
<VarDecl> -> <IDENTIFIER
<IdentifierList> -> <IdentifierList> <CM> <VarDecl>
<VarDecl> -> <IDENTIFIER
<IdentifierList> -> <IdentifierList> <CM> <VarDecl>
<VarDecl> -> <IDENTIFIER
<IdentifierList> -> <IdentifierList> <CM> <VarDecl>
<VarDecl> -> <IDENTIFIER
<IdentifierList> -> <IdentifierList> <CM> <VarDecl>
<DeclList> -> <Type> <IdentifierList> <SC>
<ProcedureHead> -> <FunctionDecl> <DeclList>
string is i
<Variable> -> <IDENTIFIER>
<Factor> -> <Constant>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
<Expr> -> <SimpleExpr>
Assignment = 1
<Assignment> -> <Variable> <ASSIGN> <Expr> <SC>
<Statement> -> <Assignment>
<StatementList> -> <Statement>
string is j
<Variable> -> <IDENTIFIER>
<Factor> -> <Constant>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
<Expr> -> <SimpleExpr>
Assignment = 2
<Assignment> -> <Variable> <ASSIGN> <Expr> <SC>
<Statement> -> <Assignment>
<StatementList> -> <StatementList> <Statement>
string is k
<Variable> -> <IDENTIFIER>
<Factor> -> <Constant>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
<Expr> -> <SimpleExpr>
Assignment = 3
<Assignment> -> <Variable> <ASSIGN> <Expr> <SC>
<Statement> -> <Assignment>
<StatementList> -> <StatementList> <Statement>
string is l
<Variable> -> <IDENTIFIER>
<Factor> -> <Constant>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
<Expr> -> <SimpleExpr>
Assignment = 4
<Assignment> -> <Variable> <ASSIGN> <Expr> <SC>
<Statement> -> <Assignment>
<StatementList> -> <StatementList> <Statement>
string is m
<Variable> -> <IDENTIFIER>
string is k
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
string is j
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
string is l
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
<AddExpr> -> <AddExpr> <PLUS> <MulExpr> 
<SimpleExpr> -> <SimpleExpr> <LT> <AddExpr> 
<Expr> -> <SimpleExpr>
Assignment = 1
<Assignment> -> <Variable> <ASSIGN> <Expr> <SC>
<Statement> -> <Assignment>
<StatementList> -> <StatementList> <Statement>
string is m
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
<Expr> -> <SimpleExpr>
<IOStatement> -> <WRITE> <LP> <Expr> <RP> <SC>
-1606403136
<Statement> -> <IOStatement>
<StatementList> -> <StatementList> <Statement>
string is i
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
string is l
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <MulExpr> <TIMES> <Factor> 
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
string is j
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
string is k
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <MulExpr> <TIMES> <Factor> 
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <SimpleExpr> <GT> <AddExpr> 
<Expr> -> <SimpleExpr>
<IOStatement> -> <WRITE> <LP> <Expr> <RP> <SC>
0
<Statement> -> <IOStatement>
<StatementList> -> <StatementList> <Statement>
string is k
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
string is l
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <MulExpr> <TIMES> <Factor> 
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
string is j
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
string is k
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
<AddExpr> -> <AddExpr> <PLUS> <MulExpr> 
string is l
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
<AddExpr> -> <AddExpr> <PLUS> <MulExpr> 
<SimpleExpr> -> <SimpleExpr> <GT> <AddExpr> 
<Expr> -> <SimpleExpr>
<IOStatement> -> <WRITE> <LP> <Expr> <RP> <SC>
1
<Statement> -> <IOStatement>
<StatementList> -> <StatementList> <Statement>
string is k
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
string is l
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
string is j
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <SimpleExpr> <GT> <AddExpr> 
<Expr> -> <SimpleExpr>
<Factor> -> <LP> <Expr> <RP>
<MulExpr> -> <MulExpr> <TIMES> <Factor> 
<AddExpr> -> <MulExpr>
string is k
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
<AddExpr> -> <AddExpr> <PLUS> <MulExpr> 
string is l
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
<AddExpr> -> <AddExpr> <PLUS> <MulExpr> 
<SimpleExpr> -> <AddExpr>
<Expr> -> <SimpleExpr>
<IOStatement> -> <WRITE> <LP> <Expr> <RP> <SC>
2126355760
<Statement> -> <IOStatement>
<StatementList> -> <StatementList> <Statement>
<ProcedureBody> -> <StatementList> <RBR>
<ProcedureDecl> -> <ProcedureHead> <ProcedureBody>
<Procedures> -> epsilon
<Procedures> -> <ProcedureDecl> <Procedures>
<Program> -> <Procedures>
