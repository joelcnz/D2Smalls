/// Gotten from D learn news group
import std.stdio, std.string;

void main() {
	auto c = (new C(7)).set(3);
	writeln(c);
}

class C {
    int i,j;
    this (int i) {
        this.i = i;
    }
    C set (int j) {
        this.j = j;
        return this;
    }
    override string toString () {
        return format("C(%s,%s)", i,j);
    }
}
