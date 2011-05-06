// Org: from stackoverflow "D 2.0: Class Arguments and Declaration Definitions with “new”?"
import std.stdio;

void main() {
	class K {
		this() { writeln("K.__ctor"); }
    }

    auto f = new class (1, "Four", 7.0) K {
		this(int a, string b, double c) {
			super();
			writefln("anon.__ctor: %s %s %s", a, b, c);
		}
		void house() {
			writeln( "House! :-D" );
		}
    };
    
    f.house;
    
    // or another way - I think this is rubbish
    class AnonymousClass : K {
		this(int a, string b, double c) {
			super();
			writefln("anon.__ctor: %s %s %s", a, b, c);
		}
    }
    auto f2 = new AnonymousClass(2, "Five", 8.0);

	class J {
		this( string info ) { writeln( "Joel - " ~ info ); }
	}
	J joel = new J( "new" ); // calls this
	joel.__ctor( "__ctor" ); // also calls this
}
