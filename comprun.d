import std.stdio: writeln;
import std.process: system;

void main(string[] args) {
	if (args.length == 1)
		return;
	string exe = args[1][0 .. $ - 2] ~ ".exe";

	system(`\jpro\dmd2\windows\bin\dmd ` ~ args[1] ~ " -d");
	system(exe);
	system("pause");
}
