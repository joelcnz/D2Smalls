import std.string;
import jec2.all;

enum
	red = RGB(255,0,0),
	yellow = RGB(255,255,0);

struct Colours {
	int red,
		yellow;
	// fill pens with different coloured inks
	void setColours() {
		red = makecol( 255, 0, 0 );
		yellow = makecol( 255, 255, 0 );
	}
}
	
void main() {
	Init( split( "-mode windowed -wxh 800 600" ) );
	Colours Colour;
	Colour.setColours;
	rectfill( screen, 10,10, 20,20, makecol( red.r, red.g, red.b ) );
	rectfill( screen, 20,10, 30,20, Colour.yellow );
	readkey;
}