//Org: Andrej Mitrovic 9 Aug 2011 - in ng: d.D
//#bit of other stuff here
import std.traits;

string FieldInit(T, int len, string fun)()
{
    string result;
//    auto fields = [__traits(allMembers, T)];
    auto fields = [__traits(allMembers, T)][ 0 .. len ];

    result ~= "this(";

    foreach (y, x; (RepresentationTypeTuple!T)[0..len])
    {
        result ~= x.stringof ~ " " ~ fields[y] ~ ", ";
    }

    result = result[0.. $-2] ~ ") { ";

    //foreach (x; 0 .. len)
    foreach( field; fields )
    {
        //result ~= "this." ~ fields[x] ~ " = " ~ fields[x] ~ "; ";
        result ~= "this." ~ field ~ " = " ~ field ~ "; ";
        result ~= "writeln( `" ~ field ~ "` );";
    }

    result ~= fun ~ "();";
    result ~= "}";

    return result;
}

struct Foo
{
    int a;
    int b;
    int c;
    int d;

    mixin( FieldInit!(typeof(this), 4, "_this") );

    int sum;
    int average;

    void _this()
    {
        sum = a + b + c + d;
        average = (a + b + c + d) / 4;
    }
}

version( all ) {
	void main()
	{
		auto foo = Foo(1, 2, 3, 4);

		assert(foo.sum == 10);
		assert(foo.average == 2);
	}
} // version

//#bit of other stuff here
import std.stdio;

version( none ) {
	struct A {
		int a;
		float b;
	}

	A[2] as = [
		0: {0, 0.0f},
		1: {5, 5.2f}
	];
	
	auto a = A( 1, 2.2 );
	A b;

	void main() {
		b = A( 2, 1.1 );
		
		int a=37;
		a=7;
		writefln("%s.init=%d", a.stringof, a.init);
		version (none) {
			readln;
		}	
	}
}
