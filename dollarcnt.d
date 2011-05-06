// Seems to work ok, seems to work better than C#, C# has funny numbers
import std.stdio;

void main() {
	char[] buf;
	for (double p = 0.0; p < 10; p += 0.01) {
		write(p);
		if (p == 0.820000000000001)
			write(" p = 0.820000000000001");
		stdin.readln(buf); // press enter
	}
}