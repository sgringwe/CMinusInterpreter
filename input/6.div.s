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
<Factor> -> <Constant>
<MulExpr> -> <Factor>
<Factor> -> <Constant>
<MulExpr> -> <MulExpr> <DIVIDE> <Factor> 
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
<Expr> -> <SimpleExpr>
<IOStatement> -> <WRITE> <LP> <Expr> <RP> <SC>
3
<Statement> -> <IOStatement>
<StatementList> -> <Statement>
string is i
<Variable> -> <IDENTIFIER>
<Factor> -> <Constant>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
<Expr> -> <SimpleExpr>
Assignment = 100
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
Assignment = 2
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
Assignment = 5
<Assignment> -> <Variable> <ASSIGN> <Expr> <SC>
<Statement> -> <Assignment>
<StatementList> -> <StatementList> <Statement>
string is j
<Variable> -> <IDENTIFIER>
string is i
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
string is k
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <MulExpr> <DIVIDE> <Factor> 
string is l
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <MulExpr> <DIVIDE> <Factor> 
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
<Expr> -> <SimpleExpr>
Assignment = 0
<Assignment> -> <Variable> <ASSIGN> <Expr> <SC>
<Statement> -> <Assignment>
<StatementList> -> <StatementList> <Statement>
string is j
<Variable> -> <IDENTIFIER>
<Factor> -> <Variable>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
<Expr> -> <SimpleExpr>
<IOStatement> -> <WRITE> <LP> <Expr> <RP> <SC>
1807760288
<Statement> -> <IOStatement>
<StatementList> -> <StatementList> <Statement>
<ProcedureBody> -> <StatementList> <RBR>
<ProcedureDecl> -> <ProcedureHead> <ProcedureBody>
<Procedures> -> epsilon
<Procedures> -> <ProcedureDecl> <Procedures>
<Program> -> <Procedures>
