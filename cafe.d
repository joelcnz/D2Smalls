// cf.bat - batch file
/*
c:
cd "\Documents and Settings\Owner\My Documents\Downloads\dmd\windows\bin"
dmd %1
pause
*/

// hello.d - D source file
import std.stdio;
import std.c.stdio;

void main() {
    writefln("This program was done in a shop (Victoria st)!");
    getchar;

    int x = 3, y = 7;
    writefln("%d x %d = %d", x, y, multiply( x, y ) );
    getchar;

    real x2 = 3.3, y2 = 7.7;
    writefln("%.2f x %.2f = %.2f", x2, y2, multiply( x2, y2 ) );
    getchar;

    auto num = new Nums!(int)( 5, 8 );
    num.process;
    num.display;
    getchar;

    auto num2 = new Nums!(real)( 5.4, 8.9 );
    num2.process;
    num2.display;
    getchar;
}

T multiply(T)(T x,T y) {
    return x * y;
}

class Nums(T) {
    T x, y, z;
    this(T x0, T y0) {
        x = x0;
        y = y0;
    }
    void process() {
        z = x * y;
    }
    void display() {
        if ( is( T == int) )
            writefln( "%d x %d = %d", x, y, z );
        if ( is( T == real) )
            writefln( "%.2f x %.2f = %.2f", x, y, z );
    }
}
