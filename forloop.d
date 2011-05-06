import std.stdio;

void main() {
	auto data="I went for a walk and  fell down a hole!";
	for(int i; i < data.length; i++)
		if (data[i] != ' ')
			write(data[i]);
		else
			continue;
	writeln("");
	foreach (d; data)
		if (d != ' ')
			write(d);
		else
			continue;
}
