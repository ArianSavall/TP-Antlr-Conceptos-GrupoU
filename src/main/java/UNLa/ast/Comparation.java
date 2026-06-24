package UNLa.ast;

import java.util.Map;

public class Comparation implements ASTNode{

    private ASTNode operand1;
    private ASTNode operand2;

    private String token_comparator;
    public Comparation(ASTNode operand1, ASTNode operand2, String token_comparator) {
        super();
        this.operand1 = operand1;
        this.operand2 = operand2;
        this.token_comparator = token_comparator;
    }
    @Override
    public Object execute(Map<String, Object> symbolTable) {

        double a = ((Number) operand1.execute(symbolTable)).doubleValue();
        double b = ((Number) operand2.execute(symbolTable)).doubleValue();

        switch(token_comparator){
            case ">":{return a > b;}
            case "<": {return a < b;}
            case "<=":{return a<=b;}
            case ">=":{return a>=b;}
            case "==":{return a==b;}
            case "!=":{return a!=b;}
        }

        return null;
    }
}
