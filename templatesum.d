//#not working, looks like a pile of junk!
import std.stdio;

struct sum(A,B) {
    A a;
    B b;

    auto opAdd(T)(T a) { return ; } // .sum!(sum,T)(this,a); }
}


struct base {
    auto opAdd(T)(T a) { return .sum!(base,T)(this,a); }
}

void main() {
    base a,b,c;

    // first a few working examples
    writeln(typeid(a));       // base
    writeln(typeid(a+b));     // sum!(base,base).sum
    writeln(typeid(a+(b+c))); // sum!(base,sum!(base,base)).sum

    sum!(sum!(base,base),base) d;
    writeln(typeid(d));       // sum!(sum!(base,base),base).sum

    // the following produces
    //   Error: recursive template expansion for
    //   template argument sum!(base,base)
    writeln(typeid((a+b)+c)); // sum!(sum!(base,base),base).sum
} 
