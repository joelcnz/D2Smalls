// dmd crash.d -d
pragma(lib, "alleg.lib");
pragma(lib, "dalleg.lib");
pragma(lib, "misc.lib");

import std.stdio;
import core.memory;
import allegro.allegro;

void main()
{
	// Init allegro
	allegro_init;
	install_keyboard;
	set_color_depth( 32 );
	set_gfx_mode(GFX_AUTODETECT_WINDOWED, 640, 480, 0, 0 );

	Thing[] things;
	auto graphic = create_bitmap( 8,8 );
	foreach ( b; 0 .. 10 ) {
		things ~= new Thing( graphic );
		//object.clear( things[ $ - 1 ] ); // this calls ~this twice
	}
	writeln("Squash");
	readkey;
//	allegro_exit;
//	GC.collect;
}

class Thing
{
	BITMAP* bmp;
	this(BITMAP* bmp)
	{
		this.bmp = bmp;
	}
	
	~this()
	{
		writeln("beetroot");
		destroy_bitmap( bmp );
		//object.clear( bmp );
	}
}
