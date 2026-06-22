grammar Simple;

@parser::header{
    import java.util.Map;
    import java.util.HashMap;
}

@parser::members {
    Map<String, Object> symbolTable = new HashMap<String, Object>();
}

program: PROGRAM ID BRACKET_OPEN
    sentence*
    BRACKET_CLOSE;

sentence: var_decl | var_assign | println;

var_decl: VAR ID SEMICOLON
        {symbolTable.put($ID.text, 0);};
var_assign: ID ASSIGN expression SEMICOLON
        {symbolTable.put($ID.text, $expression.value);};
println: PRINTLN expression SEMICOLON
        {System.out.println($expression.value);};

expression returns [Object value]:
        t1=factor {$value = $t1.value;}
        (PLUS t2=factor {
            // Manejo básico para permitir concatenación de strings o suma de enteros
            if ($value instanceof Integer && $t2.value instanceof Integer) {
                $value = (int)$value + (int)$t2.value;
            } else {
                $value = String.valueOf($value) + String.valueOf($t2.value);
            }
        }
        | MINUS t2=factor {$value = (int) $value - (int)$t2.value;})*;

factor returns [Object value]:
        t1=term {$value = $t1.value;}
        (MULT t2=term {$value = (int) $value * (int)$t2.value;}
        | DIV t2=term {$value = (int) $value / (int)$t2.value;})*;

term returns [Object value]:
        NUMBER {$value = Integer.parseInt($NUMBER.text);}
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

ID: [a-zA-Z_][a-zA-Z0-9_]*;

NUMBER: [0-9]+;

INT: NUMBER;
FLOAT: NUMBER DOT NUMBER;
STRING: '"' ~'"'* '"';

LINE_COMMENT: '//' ~[\r\n]* -> skip;
MULTIPLE_LINE_COMMENT:'/*' .*? '*/' -> skip;
WS:	[ \t\r\n]+ -> skip;