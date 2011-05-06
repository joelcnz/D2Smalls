import std.stdio;

void main() {
	int a=1;
	int b=2;
	int add(int a,int b) {
	  return a+b;
	}
	int c=add(a,b);
	writeln("Result:",c);
}