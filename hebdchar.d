//#I normally avoid file stream
//#file class things don't have a get filename option
// Some is copied from some where the first two sigifcant lines
import std.stdio;
import std.stream;
import std.string;
import std.array;

void main() {
  dchar w_sonderzeichen= '\u20ac';    // Euro Zeichen
  writefln("w_sonderzeichen = %s ",w_sonderzeichen) ;

	auto names = 
		split("Alef Bet Gimel Dalet He Vav Zayen Het Tet Yod Final_Kaf "
			"Kaf Lamed Final_Mem Mem Final_Nun Nun Samekh Ayin Final_Pe "
			"Pe Final_Tsadi Tsadi Qof Resh Shin Tav");
	foreach (ref name; names)
		name = replace(name, "_", " ");
	writeln(names.length, " Names");
	dchar start='\u05D0'; // Alef
	int i=0;
	auto fileName = "Hebrew.txt"; //#file class things don't have a get filename option
	//#I normally avoid file stream
	Stream file = new BufferedFile(fileName, FileMode.Out); // out to a text file
	foreach (dchar letter; start .. start + names.length) {
		stdout.writefln("%-12s [%s]", names[i++], letter);
		file.write(letter);
	}
	file.close;
	writeln("Written file: ", fileName);
}

// And the iron rusts and the grass and bushes grow up around in and out of the machinary left for dead, yes, they were always dead from the beginning
/+
import std.stdio;
import std.string;
import std.format;
import std.stream;
import std.array;

void main() {
  dchar w_sonderzeichen= '\u20ac';    // Euro Zeichen
  writefln("w_sonderzeichen = %s ",w_sonderzeichen) ;

	auto names = 
		split("Alef Bet Gimel Dalet He Vav Zayen Het Tet Yod Final_Kaf "
			"Kaf Lamed Final_Mem Mem Final_Nun Nun Samekh Ayin Final_Pe "
			"Pe Final_Tsadi Tsadi Qof Resh Shin Tav");
	writeln(names.length, " Names");
	dchar start='\u05D0';
	int i=0;
	Stream file = new BufferedFile("z.txt");
	scope (exit) {
		writeln("File closed.");
		file.close;
	}
	auto writer = appender!string();
    //formattedWrite(writer, "%s is the ultimate %s.", 42, "answer");
	foreach (dchar letter; start .. start + names.length) {
		formattedWrite(writer, "%-12s [%s]", names[i++], letter);
		//stdout.writefln("%-12s [%s]", names[i++], letter);
//		file.write(writer.data);
	}
	file.write(cast(dchar[])writer.data);
}
+/
