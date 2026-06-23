grammar Simple;

@parser::header{
    import java.util.Map;
    import java.util.HashMap;
}

@parser::members {
    Map<String, Object> symbolTable = new HashMap<String, Object>();

    private Object sumar(Object a, Object b) {
        try{
            double num1 = ((Number)a).doubleValue();
            double num2 = ((Number)b).doubleValue();

            double result = num1 + num2;

            if (result % 1 == 0) {
                return (int) result;
            }

            return result;
        }catch(Exception e){
            return String.valueOf(a) + String.valueOf(b);
        }
    }

    private Object restar(Object a, Object b) {
        double num1 = ((Number)a).doubleValue();
        double num2 = ((Number)b).doubleValue();

        double result = num1 - num2;

        if (result % 1 == 0) {
            return (int) result;
        }

        return result;
    }

    private Object multiplicar(Object a, Object b) {
        double num1 = ((Number)a).doubleValue();
        double num2 = ((Number)b).doubleValue();

        double result = num1 * num2;

        if (result % 1 == 0) {
            return (int) result;
        }

        return result;
    }

    private Object dividir(Object a, Object b) {
        double divisor = ((Number)b).doubleValue();

        // Buena práctica: Evitar la división por cero
        if (divisor == 0.0) {
            System.err.println("Error: División por cero.");
            return 0;
        }

        double result = ((Number)a).doubleValue() / divisor;

        if (result % 1 == 0) {
            return (int) result;
        }

        return result;
    }
}

program: PROGRAM ID BRACKET_OPEN
    sentence*
    BRACKET_CLOSE;

sentence: var_decl | var_assign | println;

var_decl: VAR ID (ASSIGN expression)? SEMICOLON
        {
            try{
                symbolTable.put($ID.text, $expression.value);
            }catch(NullPointerException e){
                symbolTable.put($ID.text, 0);
            }
        };
var_assign: ID ASSIGN expression SEMICOLON
        {symbolTable.put($ID.text, $expression.value);};
println: PRINTLN expression SEMICOLON
        {System.out.println($expression.value);};

expression returns [Object value]:
        t1=factor {$value = $t1.value;}
        (PLUS t2=factor {$value = sumar($value, $t2.value);}
        | MINUS t2=factor {$value = restar($value, $t2.value);})*;

factor returns [Object value]:
        t1=term {$value = $t1.value;}
        (MULT t2=term {$value = multiplicar($value, $t2.value);}
        | DIV t2=term {$value = dividir($value, $t2.value);})*;

term returns [Object value]:
        INT {$value = Integer.parseInt($INT.text);}
        | FLOAT {$value = Double.valueOf($FLOAT.text);}
        | STRING {
            String text = $STRING.text;
            $value = text.substring(1, text.length() - 1);
        }
        | ID {
            $value = symbolTable.get($ID.text);
            if ($value == null) {
                System.err.println("Error: Variable no definida -> " + $ID.text);
                $value = 0;
            }
        }
        | PAR_OPEN e=expression PAR_CLOSE {$value = $e.value;};

PROGRAM: 'program';
PRINTLN: 'println';
VAR: 'var';

PLUS: '+';
MINUS: '-';
MULT: '*';
DIV: '/';

AND: '&&';
OR: '||';
NOT: '!';

GT: '>';
LT: '<';
GEQ: '>=';
LEQ: '<=';
EQ: '==';
NEQ: '!=';

ASSIGN: '=';

BRACKET_OPEN: '{';
BRACKET_CLOSE:'}';

PAR_OPEN:'(';
PAR_CLOSE:')';

DOUBLE_QUOTE: '"';

DOT: '.';

SEMICOLON:';';

INT: NUMBER;
FLOAT: NUMBER DOT NUMBER;
STRING: '"' ~'"'* '"';

ID: [a-zA-Z_][a-zA-Z0-9_]*;

NUMBER: [0-9]+;

LINE_COMMENT: '//' ~[\r\n]* -> skip;
MULTIPLE_LINE_COMMENT:'/*' .*? '*/' -> skip;
WS:	[ \t\r\n]+ -> skip;