//#why the []
/*
Org: bearophile date: 10 Mar '11 12:25pm
dmd -O -release test.d
*/
import std.c.stdio: printf;

union Four {
    ubyte[4] a;
    uint u;
}

void showFour(Four f) {
    printf("f.u: %u\n", f.u);
    printf("f.a: [%d, %d, %d, %d]\n",
           cast(int)f.a[0], cast(int)f.a[1],
           cast(int)f.a[2], cast(int)f.a[3]);
}

void main() {
    Four f;
    f.a[] = [1, 2, 3, 4];
	showFour(f);
    foreach( a; 0 .. 4 ) {
		f.u = (f.u << 8) | (f.u >> 24);
		showFour(f);
		printf("\n");
	}

    // alternative
	printf( "\nalternative ( asm { rol  u2, 8; } ):\n" );
    f.a = [1, 2, 3, 4]; //#why the []
    showFour(f);
    foreach( a; 0 .. 4 ) {
		uint u2 = f.u;
		printf("u2: %u\n", u2);
		asm {
			rol  u2, 8;
		}
		f.u = u2;
		showFour(f);
	}
}
