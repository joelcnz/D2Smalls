// Org ng d.learn - bearophile 2
// I think this is stupid - 5 Mar 2011
import core.stdc.stdio: printf;
import std.stdio;

struct Foo {
    bool b;
    this(bool b_) { this.b = b_; }
	string toString() { return b ? "TRUE" : "FALSE"; }
}

const Foo* TRUE, FALSE;

static this() {
    TRUE = new const(Foo)(true);
    FALSE = new const(Foo)(false);
}

const(Foo)* not(const Foo* op) {
    return (op == TRUE) ? FALSE : TRUE;
}

void main() {
    assert(not(TRUE) == FALSE);
    printf("%x\n", TRUE.b );
    printf("%x\n", FALSE.b);
    printf("%x\n", not(TRUE).b);
    printf("%x\n", not(not(TRUE)).b);
}

