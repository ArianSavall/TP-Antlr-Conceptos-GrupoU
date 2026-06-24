package UNLa.ast;

import java.util.List;
import java.util.Map;

public class WhileNode implements ASTNode {
    private ASTNode condition;
    private List<ASTNode> body;

    public WhileNode(ASTNode condition, List<ASTNode> body) {
        this.condition = condition;
        this.body = body;
    }

    @Override
    public Object execute(Map<String, Object> symbolTable) {
        while ((Boolean) condition.execute(symbolTable)) {
            for (ASTNode sentence : body) {
                sentence.execute(symbolTable);
            }
        }
        return null;
    }
}
