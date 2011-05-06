import std.stdio;

void main() {
	int x=5,y=1;
	(true ? x : y)+=5;
	(false ? x : y)+=9;
	x==10 && y==10 && writeln("x=", x, ", y=", y);
}
