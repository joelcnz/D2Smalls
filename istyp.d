//#hi's from Alan - if it worked
import std.stdio;

void main(char[][] args) {
	HiInter[] olderSibs;
	if ( args.length==1 )
		args~=cast(char[])"ra";
	foreach(id;args[1] ) {
		switch (id ) {
			case 'r':
				olderSibs~=new Ria;
			break;
			case 'a':
				olderSibs~=new Alan;
			break;
		}
	}
	class A {
		void sayHi() {
			writefln(cast(char[])"Hi - A");
		}
	}
	class R {
		void sayHi() {
			writefln(cast(char[])"Hi - R");
		}
	}
	
	auto a=new A;
	auto r=new R;
	
	if ( is(a==A) )
		writefln(cast(char[])"is(a==A)");
	if ( is(r==A) )
		writefln(cast(char[])"is(r==A)");
	
	//#hi's from Alan - if it worked
	foreach(s;olderSibs) {
		if ( is(h:Alan) )
			s.hi;
	}
}

interface HiInter {
	void hi();
}

class Alan : HiInter {
	 void hi() {
		writefln(cast(char[])"Hi! - Alan");
	}
}

class Ria : HiInter {
	 void hi() {
		writefln(cast(char[])"Hi! - Ria");
	}
}
