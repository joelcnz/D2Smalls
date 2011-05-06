// From spir's in the D.Learn forum
import std.stdio;
import std.traits;

P[] hof1 (P, alias f) (uint n) {
    P[] ps;
    foreach (i ; 0..n)
        ps ~= f();
    return ps;
}
P[] hof2 (P) (uint n, P function () f) {
    P[] ps;
    foreach (i ; 0..n)
        ps ~= f();
    return ps;
}
auto hof3 (alias f) (uint n) {
    alias ReturnType!f P;
    P[] ps;
    foreach (i ; 0..n)
        ps ~= f();
    return ps;
}
ReturnType!f[] hof4 (alias f) (uint n) {
    alias ReturnType!f P;
    P[] ps;
    foreach (i ; 0..n)
        ps ~= f();
    return ps;
}
ReturnType!f[] hof5 (alias f) (uint n, ReturnType!f p) {
    alias ReturnType!f P;
    P[] ps;
    foreach (i ; 0..n)
        ps ~= f(p);
    return ps;
}

int f () { return 1; }
int f2 (int i) { return i; }

unittest {
    writeln( hof1!(int, f)(3) );

    writeln( hof2!int(3, &f) );
    writeln( hof2(3, &f) );

    writeln( hof3!f(3) );
    writeln( hof4!f(3) );

    writeln( hof5!f2(3, 1) );
}
void main () {} 
