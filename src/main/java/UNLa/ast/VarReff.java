package UNLa.ast;

import java.util.Map;

public class VarReff implements ASTNode{

    private String name;

    public VarReff(String name) {
        this.name = name;
    }

    @Override
    public Object execute(Map<String, Object> symbolTable) {

        return symbolTable.get(name);
    }
}
