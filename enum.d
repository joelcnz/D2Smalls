import std.stdio;

void main() {
	enum Command : char {HELP='h'};
	if ( Command.HELP == 'h')
		write("It is!");
	// Not as good as C#
	enum Num {zero, one};
	Num num = Num.zero;
	write("\r\n" ~ Num.zero.stringof);
	write("\r\n" ~ num.stringof);
}
