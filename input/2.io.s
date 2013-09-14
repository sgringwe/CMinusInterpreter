<Type> -> <INTEGER>
<FunctionDecl> ->  <Type> <IDENTIFIER> <LP> <RP> <LBR>
<ProcedureHead> -> <FunctionDecl>
ouput integers:
<IOStatement> -> <WRITE> <LP> <StringConstant> <RP> <SC>
<Statement> -> <IOStatement>
<StatementList> -> <Statement>
<Factor> -> <Constant>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
<SimpleExpr> -> <AddExpr>
<Expr> -> <SimpleExpr>
<IOStatement> -> <WRITE> <LP> <Expr> <RP> <SC>
1
<Statement> -> <IOStatement>
<StatementList> -> <StatementList> <Statement>
<Factor> -> <Constant>
<MulExpr> -> <Factor>
<AddExpr> -> <MulExpr>
<Factor> -> <Constant>
<MulExpr> -> <Factor>
<AddExpr> -> <AddExpr> <PLUS> <MulExpr> 
<SimpleExpr> -> <AddExpr>
<Expr> -> <SimpleExpr>
<IOStatement> -> <WRITE> <LP> <Expr> <RP> <SC>
3
<Statement> -> <IOStatement>
<StatementList> -> <StatementList> <Statement>
<ProcedureBody> -> <StatementList> <RBR>
<ProcedureDecl> -> <ProcedureHead> <ProcedureBody>
<Procedures> -> epsilon
<Procedures> -> <ProcedureDecl> <Procedures>
<Program> -> <Procedures>
