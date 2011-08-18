import std.stdio;

struct Foo
{   
    int a = 7;
    int bar() { return a; }
}


int foo(int delegate() dg)
{
    return dg() + 1;
}

void main()
{
    int x = 27;
    int abc() { return x; }
    Foo f;
    int i;

	void pnt(string tx) {
		writeln(tx, ": ", i);
	}
	pnt("Before");
    i = foo(&abc);      /* i is set to 28 */
	pnt("After");
	pnt("Before");
    i = foo(&f.bar);    /* i is set to 8 */
	pnt("After");
}
