//#foreach(q, i, t; thg)
import std.stdio;

class Thing {
	string[] names;
	this(string[] names) {
		this.names = names;
	}

	int opApply(int delegate(ref string) dg) { // foreach (t; thg)
        int result = 0;

        for (int i = 0; i < names.length; i++) {
            result = dg(names[i]);
            if (result)
                break;
        }
        return result;
	}

	int opApply(int delegate(ref int, ref string) dg) { // foreach (i, t; thg)
        int result = 0;

        for (int i = 0; i < names.length; i++) {
            result = dg(i, names[i]);
            if (result)
                break;
        }
        return result;
	}

	int opApply(int delegate(ref char, ref int, ref string) dg) { // foreach (q, i, t; thg)
        int result = 0;

        for (int i = 0; i < names.length; i++) {
            result = dg(names[i][1], i, names[i]);
            if (result)
                break;
        }
        return result;
	}
	
	void slice(int start, int end, void delegate(ref string) dg) {
		for (int i = start; i < end; i++) {
			dg(names[i]);
		}
	}
}

class Thing2Man(T) {
	T _head;

	typeof(this) add(T thg2) {
		thg2.next = _head;
		_head = thg2;

		return this;
	}
	
	int opApply(int delegate(ref T) dg) {
		int result;
		auto current = _head;
		while ( current !is null ) {	
			result = dg(current);
			if ( result )
				break;
			current = current.next;
		}
		return result;
	}
}

class SomeThing2 {
	SomeThing2 next;

	char c; // payload
	
	void print()
	{
		write("#");
	}
}

class Thing2 : SomeThing2 {
	this(char c0) {
		c  = c0;
	}
	override void print() {
		write(c);
	}	
}

void main() {
	auto thg = new Thing(["zero", "one", "two", "three"]);
	foreach(i, ref t; thg)
		writeln(i, ".", " [", t, "]"), t = "*" ~ t ~ "*";
	foreach(t; thg)
		writeln(t);

	writeln("foreach(q, i, ref t; thg)");
	foreach(c, i, t; thg) { //#foreach(q, i, t; thg)
		writeln(i, ". result = '", c, "' ", " [", t, "]");
	}
		
	thg.slice( 1, 3,
		(ref string h) {
		  h = ">" ~ h ~ "<";
		}
	);
	
	thg.slice( 1, 3,
		(ref string h) {
		  writeln( h );
		}
	);
	
	auto thg2man = new Thing2Man!SomeThing2;
	foreach (c; "hsimaH")
		thg2man.add( new Thing2( c ) );
	thg2man.add( new Thing2( ' ' ) ).
			add( new Thing2( 'm' ) ).
			add( new Thing2( 'i' ) ).
			add( new Thing2( 'T' ) );
	foreach (t2; thg2man) {
		t2.print;
	}
}
