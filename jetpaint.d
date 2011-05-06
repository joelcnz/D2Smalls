pragma( lib, "liballegro5.lib" );
pragma( lib, "libdallegro5.lib" );
pragma( lib, "jeca.lib" );

import std.stdio;
import jeca.all;

void main( string[] args ) {
	scope( exit ) {
		shutdown_input;
		writeln( "shutdown_input done" );
	}
	
	Init( args );
	
	auto plane = new Bmp( `has_a-7e-title.jpg` );
	
	ALLEGRO_EVENT event;
	int x = -al_get_bitmap_width( plane() );
	auto done = false;
	while( ! done ) {
		
		while(al_get_next_event( QUEUE, &event))
		{
			switch(event.type)
			{
				// close button includes Alt + F4
				case ALLEGRO_EVENT_DISPLAY_CLOSE:
				{
					done = true;
					break;
				}
				default:
				break;
			}
		}
		
		al_clear_to_color( Colour.black );
		
		al_draw_bitmap( plane(), (x > al_get_bitmap_width( plane() ) ? 250 : x), 100, 0 );
		
		al_flip_display;
		
		al_rest( 0.005 );
		x += 1;
	}
}
