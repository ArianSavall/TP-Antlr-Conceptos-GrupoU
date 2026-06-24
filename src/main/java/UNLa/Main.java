package UNLa;

import java.io.File;
import java.io.IOException;
import org.antlr.v4.runtime.CharStream;
import org.antlr.v4.runtime.CharStreams;
import org.antlr.v4.runtime.CommonTokenStream;

public class Main {

    private static final String EXTENSION = "smp";
    private static final String DIRBASE = "src/test/resources/";

    public static void main(String[] args) throws IOException {
        String files[];

        if (args.length == 0){
            File carpeta = new File(DIRBASE);
            File[] archivosEncontrados = carpeta.listFiles((dir, name) -> name.endsWith("." + EXTENSION));

            if (archivosEncontrados != null && archivosEncontrados.length > 0){
                files = new String[archivosEncontrados.length];
                for (int i = 0; i < archivosEncontrados.length; i++){
                    files[i] = archivosEncontrados[i].getName();
                }
            }else {
                files = new String[]{ "test." + EXTENSION};
            }

        }else {
            files = args;
        }

        System.out.println("Dirbase: " + DIRBASE);
        for (String file : files){
            System.out.println("START: " + file);

            CharStream in = CharStreams.fromFileName(DIRBASE + file);
            SimpleLexer lexer = new SimpleLexer(in);
            CommonTokenStream tokens = new CommonTokenStream(lexer);
            SimpleParser parser = new SimpleParser(tokens);
            SimpleParser.ProgramContext tree = parser.program();
            SimpleCustomVisitor visitor = new SimpleCustomVisitor();
            visitor.visit(tree);

            System.out.println("FINISH: " + file);
        }
    }
}
