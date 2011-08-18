module mulitypearray;

import std.stdio, std.string;

void main() {
	alias Object O;
	Object[] objs = [cast(O)new A, new B, new C];
	objs~=new A;
	objs~=new B;
	
	foreach (o; objs)
		switch (o.classinfo.name) {
			case "mulitypearray.A":
				writeln((cast(A)o).num);
			break;
			case "mulitypearray.B":
				writeln((cast(B)o).str);
			break;
			default:
				writeln("Type unicounted for (see your vendor now!)");
			break;
		}
	writeln((cast(C)objs[2]).realnum);
	
	foreach( index; 0 .. 10 )
		writeln( "A cow was found by the light of the moon".split[ index .. index + 2 ] ),
		++index;
}

class A {
	int num=7;
}

class B {
	string str="flat";
}

class C {
	real realnum=0.37;
}
