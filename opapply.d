//#foreach(q, i, t; thg)
import std.stdio;
import std.algorithm;

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
            result = dg(names[i][1], i, names[i]); // names[i][1] - 1 to skip the '*'
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
	
	size_t length() {
		auto current = _head;
		int i = 0;
		while( current !is null ) {
			i++;
			current = current.next;
		}
		
		return i;
	}
	
	T opIndex( size_t iTarg ) {
		auto current = _head;
		size_t i = 0;
		while( current !is null ) {
			if ( i == iTarg )
				break;
			i++;
			current = current.next;
		}
		
		return current;
	}
	
	void doSort() {
		T[] arr;
		auto current = _head;
		while( current !is null ) {
			arr ~= current;
			current = current.next;
		}
		
		sort!"a > b"( arr ); // gets swapped with add( item )
		_head = null;
		foreach( item; arr )
			add( item );
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

	override int opCmp( Object obj ) {
		auto a = c;
		auto conv = cast( typeof( this ) )obj;
		auto b = conv.c;
		void toLower( ref char l ) {
			if ( l >= 'A' && l <= 'Z' )
				l = cast(char)('a' + l - 'A');
		}
		foreach( l; [&a, &b] )
			toLower( *l );
			
		if ( a < b )
			return -1;
		else if ( a > b )
			return 1;
		return 0;
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
	with( thg2man )
		add( new Thing2( ' ' ) ),
		add( new Thing2( 'y' ) ),
		add( new Thing2( 'h' ) ),
		add( new Thing2( 't' ) ),
		add( new Thing2( 'o' ) );
	thg2man.add( new Thing2( 'm' ) ).
			add( new Thing2( 'i' ) ).
			add( new Thing2( 'T' ) );
	foreach (t2; thg2man ) {
		t2.print;
	}
	writeln( "\nGet length and indexing: " );
	foreach( i; 0 .. thg2man.length )
		thg2man[ i ].print;
	write( "\nNow sort:" );
	thg2man.doSort;
	foreach (t2; thg2man ) {
		t2.print;
	}
	writeln();
}
