fun my_func1 u =
        (TextIO.print "Hello World\n";
         let
             val fd = TextIO.openIn "readFile.txt";
             val fileContents = TextIO.inputAll fd;
         in
             TextIO.close fd;
             TextIO.print "fileContents = ";
             TextIO.print (fileContents)
         end);

fun splitwords str = String.tokens Char.isSpace str;

fun wc_lines lines = List.sum (List.map (List.length o splitwords) lines);

fun wordcount u =
    case TextIO.inputLinesFrom (List.hd (CommandLine.arguments()))
    of SOME lines =>
      (TextIO.print (Int.toString (wc_lines lines)); TextIO.output1 TextIO.stdOut #" ";
       TextIO.print (Int.toString (List.length lines)); TextIO.output1 TextIO.stdOut #"\n");

wordcount ();
