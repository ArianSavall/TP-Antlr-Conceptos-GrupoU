package UNLa.ast;

import java.util.Map;

public class VarAssign implements ASTNode{

    private String name;
    private ASTNode expresion;

    public VarAssign(String name, ASTNode expresion) {
        this.name = name;
        this.expresion = expresion;
    }

    @Override
    public Object execute(Map<String, Object> symbolTable) {
        symbolTable.put(name, expresion.execute(symbolTable));
        return null;
    }
}
