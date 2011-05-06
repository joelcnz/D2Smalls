//#dmd enummixin.d -c
// Found in ng 27 Feb 2011 3:56pm - and does not work, look at those mad mixin's

void funcA(A a) {}
void funcB(B b) {}

enum stdAccess = q{
    STD_ELEMENT_1 = 17,
    STD_ELEMENT_2 = 42,
};

enum A {
    mixin(stdAccess),
    A_ACCESS_1 = 0x80
}

enum B {
    mixin(stdAccess),
    B_ACCESS_1 = 0x80,
	END_OF_B
}

//#dmd enummixin.d -c
/*
void main() {
	foreach( e; B.min .. B.max ) {
		write( e, " " );
	}
}
*/