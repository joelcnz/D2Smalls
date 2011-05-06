module mulitypearray;

import std.stdio;

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
