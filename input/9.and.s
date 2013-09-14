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
Assignment = 0
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
Assignment = 0
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
Assignment = 1
<Assignment> -> <Variable> <ASSIGN> <Expr> <SC>
<Statement> -> <Assignment>
<StatementList> -> <StatementList> <Statement>
string is i
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
<Expr> -> <SimpleExpr>
string is j
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
<Expr> -> <Expr> <AND> <SimpleExpr> 
<IOStatement> -> <WRITE> <LP> <Expr> <RP> <SC>
1
<Statement> -> <IOStatement>
<StatementList> -> <StatementList> <Statement>
string is i
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
<Expr> -> <SimpleExpr>
string is i
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
<Expr> -> <Expr> <AND> <SimpleExpr> 
<IOStatement> -> <WRITE> <LP> <Expr> <RP> <SC>
1
<Statement> -> <IOStatement>
<StatementList> -> <StatementList> <Statement>
string is k
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
<Expr> -> <SimpleExpr>
string is l
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
<Expr> -> <Expr> <AND> <SimpleExpr> 
<IOStatement> -> <WRITE> <LP> <Expr> <RP> <SC>
1
<Statement> -> <IOStatement>
<StatementList> -> <StatementList> <Statement>
string is k
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
<Expr> -> <SimpleExpr>
string is j
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
<Expr> -> <Expr> <AND> <SimpleExpr> 
<IOStatement> -> <WRITE> <LP> <Expr> <RP> <SC>
1
<Statement> -> <IOStatement>
<StatementList> -> <StatementList> <Statement>
<ProcedureBody> -> <StatementList> <RBR>
<ProcedureDecl> -> <ProcedureHead> <ProcedureBody>
<Procedures> -> epsilon
<Procedures> -> <ProcedureDecl> <Procedures>
<Program> -> <Procedures>
