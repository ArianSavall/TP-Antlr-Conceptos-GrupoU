package UNLa.ast;

import java.util.Map;

public class Divition implements ASTNode{
    private ASTNode operand1;
    private ASTNode operand2;

    public Divition(ASTNode operand1, ASTNode operand2) {
        super();
        this.operand1 = operand1;
        this.operand2 = operand2;
    }

    @Override
    public Object execute(Map<String, Object> symbolTable) {
        double divisor = ((Number) operand2.execute(symbolTable)).doubleValue();
        if (divisor == 0.0) {
            System.err.println("Error: División por cero.");
            return 0;
        }

        double result = ((Number) operand1.execute(symbolTable)).doubleValue() / divisor;

        if (result % 1 == 0) {
            return (int) result;
        }

        return result;
    }
}
