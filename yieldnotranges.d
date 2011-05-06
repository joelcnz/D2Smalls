/// Not work
module yieldnotranges;

import std.stdio;

struct Foo {
    int a = 1, b = 1;

    int front() @property {
        return b;
    }

    void popFront() {
        int temp = a + b;
        a = b;
        b = temp;
    }

    // This range is infinite, i.e. never empty.
    enum bool empty = false;

    typeof(this) save() @property { return this; }
}

void main()
{
	Foo foo;
	foreach ( elem; foo )
	{
		writeln( elem.a, ' ', elem.b );
	}
}
