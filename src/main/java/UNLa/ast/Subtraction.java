package UNLa.ast;

import java.util.Map;

public class Subtraction implements ASTNode{
    private ASTNode operand1;
    private ASTNode operand2;

    public Subtraction(ASTNode operand1, ASTNode operand2) {
        super();
        this.operand1 = operand1;
        this.operand2 = operand2;
    }

    @Override
    public Object execute(Map<String, Object> symbolTable) {
        double num1 = ((Number) operand1.execute(symbolTable)).doubleValue();
        double num2 = ((Number) operand2.execute(symbolTable)).doubleValue();

        double result = num1 - num2;

        if (result % 1 == 0) {

            return (int) result;
        }

        return result;
    }
}
