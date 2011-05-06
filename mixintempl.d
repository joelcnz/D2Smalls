template Foo()
{
    int i;
    char[] s;
}

struct S
{
    mixin Foo;
}

void main() {
	S s;
	s.i = 64;
	s.s = "sixty four";
}

version( none ) {
// unfinished from d.learn - 26 Jan
import std.stdio;

template chainedMixin( alias head, tail... ) {
    mixin head;
    mixin chainedMixin!tail;
}

template chainedMixin( alias head ) {
    mixin head;
}

void main() {
	chainedMixin( );
}

}