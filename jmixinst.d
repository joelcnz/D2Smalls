import std.stdio;

void main()
{
    int j;
    mixin(`
	int x = 3;
	for (int i = 0; i < 3; i++)
	    writefln("%d, %d",x + i, ++j);
	`);    // ok

    const char[] s = "int y;";
    mixin(s);  // ok
    y = 4;     // ok, mixin declared y
		writefln("y=%d",y);

    //char[] t = "y = 3;";
    //mixin(t);  // error, t is not evaluatable at compile time

//    mixin("y =") 4; // error, string must be complete statement

    mixin("y =" ~ "4;");  // ok
}
