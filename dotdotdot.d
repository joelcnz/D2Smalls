import std.stdio;
import std.conv;

struct Point {
	private int m_xpos, m_ypos;
	
	@property ref auto xpos() { return m_xpos; }
	@property ref auto ypos() { return m_ypos; }
	
	this( int xpos0, int ypos0 ) {
		xpos = xpos0;
		ypos = ypos0;
	}
	
	auto toString() {
		return "Point( " ~ to!string( xpos ) ~ ", " ~ to!string( ypos ) ~ " )";
	}
}

void main() {
	dotDotDot( "Axe", Point( 14, 12 ), "Hammer", 1948 );
	pointDotDotDot( Point( 3, 2 ), Point( 640, 480 ) );
}

void pointDotDotDot( Point[] points... ) {
	foreach( i, e; points ) {
		writeln( i, " - ", e );
	}
}

void dotDotDot( ... ) {
	writeln("\n"); // two new lines
	foreach( i, arg; _arguments ) {
		
		write( i, ") Type: ", arg );
		if ( arg == typeid( string ) ) { // immutable(char)[]
			auto txt = *cast(string*)_argptr;
			writeln( " - ", txt );
			_argptr += txt.sizeof;
		} else if ( arg == typeid( Point ) ) {
			auto pnt = *cast(Point*)_argptr;
			writeln( " - ", pnt );
			_argptr += pnt.sizeof;
		} else if ( arg == typeid( int ) ) { // immutable(char)[]
			auto number = *cast(int*)_argptr;
			writeln( " - ", number );
			_argptr += number.sizeof;
		}
		writeln("");
	}
}
