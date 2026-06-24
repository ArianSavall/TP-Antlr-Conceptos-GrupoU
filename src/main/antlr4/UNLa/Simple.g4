grammar Simple;

@parser::header{
    import java.util.Map;
    import java.util.HashMap;
    import UNLa.ast.*;
}

@parser::members {
    Map<String, Object> symbolTable = new HashMap<String, Object>();
}

program: PROGRAM ID BRACKET_OPEN
    {
         List<ASTNode> body = new ArrayList<ASTNode>();
         Map<String, Object> symbolTable = new HashMap<String, Object>();
    }
    (sentence{body.add($sentence.node);})*
    BRACKET_CLOSE
    {
        for(ASTNode n : body){
            n.execute(symbolTable);
        }
    };

sentence returns [ASTNode node]:  println {$node = $println.node;}
                | conditional{$node = $conditional.node;}
                | var_decl {$node = $var_decl.node;}
                | var_assign {$node = $var_assign.node;};

println returns [ASTNode node]: PRINTLN expression SEMICOLON
        {$node = new Println($expression.node);};

conditional returns [ASTNode node]: IF PAR_OPEN expression PAR_CLOSE
             {
                List<ASTNode> body = new ArrayList<ASTNode>();
             }
             BRACKET_OPEN (s1=sentence{body.add($s1.node);})* BRACKET_CLOSE
             ELSE
             {
                List<ASTNode> elseBody = new ArrayList<ASTNode>();
             }
             BRACKET_OPEN (s2=sentence{elseBody.add($s2.node);})* BRACKET_CLOSE
             {
                $node = new If($expression.node, body, elseBody);
             }
             ;

var_decl returns [ASTNode node]:

    VAR ID (ASSIGN expression)? SEMICOLON {
        try{
            $node = new VarAssign($ID.text, $expression.node);
        }catch(NullPointerException e){
            $node = new VarDecl($ID.text);
        }
    }
;

var_assign returns [ASTNode node]:

    ID ASSIGN expression SEMICOLON {$node = new VarAssign($ID.text, $expression.node);}

;

expression returns [ASTNode node]:
    t1=comparation {$node = $t1.node;}
;
comparation returns [ASTNode node]:
    t1=arithmetic_expr {$node = $t1.node;}
    (op=COMPARATOR t2=arithmetic_expr {$node = new Comparation($node, $t2.node, $op.text);})?
;

arithmetic_expr returns [ASTNode node]:
        t1=factor {$node = $t1.node;}
        (PLUS t2=factor {$node = new Addition($node, $t2.node);}
        | MINUS t2=factor {$node = new Subtraction($node, $t2.node);})*;

factor returns [ASTNode node]:
        t1=term {$node = $t1.node;}
        (MULT t2=term {$node = new Multiplication($node, $t2.node);}
        | DIV t2=term {$node = new Divition($node, $t2.node);})*;

term returns [ASTNode node]:
        INT {$node = new Constant(Integer.parseInt($INT.text));}
        | FLOAT {$node = new Constant(Double.parseDouble($FLOAT.text));}
        | STRING {
            String textoConComillas = $STRING.text;
            String textoLimpio = textoConComillas.substring(1, textoConComillas.length() - 1);
            $node = new Constant(textoLimpio);
        }
        | ID {$node = new VarReff($ID.text);}
        | BOOLEAN {$node = new Constant(Boolean.parseBoolean($BOOLEAN.text));}
        | PAR_OPEN e=expression {$node = $expression.node;} PAR_CLOSE;

PROGRAM: 'program';
PRINTLN: 'println';
VAR: 'var';
IF: 'if';
ELSE: 'else';

PLUS: '+';
MINUS: '-';
MULT: '*';
DIV: '/';

AND: '&&';
OR: '||';
NOT: '!';

COMPARATOR: GT | LT | EQ | NEQ | GEQ | LEQ;

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

BOOLEAN: 'true' | 'false';

INT: NUMBER;
FLOAT: NUMBER DOT NUMBER;
STRING: '"' ~'"'* '"';

ID: [a-zA-Z_][a-zA-Z0-9_]*;

NUMBER: [0-9]+;

LINE_COMMENT: '//' ~[\r\n]* -> skip;
MULTIPLE_LINE_COMMENT:'/*' .*? '*/' -> skip;
WS:	[ \t\r\n]+ -> skip;