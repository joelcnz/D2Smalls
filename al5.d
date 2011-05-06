/*
 * DAllegro5 - yay!
 */
module al5;

pragma( lib, "allegro5.lib" );
pragma( lib, "dallegro5.lib" );
pragma( lib, "jeca.lib" );

import std.stdio;
import std.string;
import jeca.all;

void main( string[] args ) {
	try {
		Init( args ); //[ "-mode window -wxh 800 600 -depth 32" ] );
	} catch( Exception e ) {
		writeln( "Caught in test.d in main: " ~ e.toString );
	}
	
	//BMP = al_load_bitmap("mysha.pcx");
	BMP = al_load_bitmap( `c:\odds\clut2x.jpg` );
	FONT = al_load_font("DejaVuSans.ttf", 18, 0);
	
	assert( BMP !is null && FONT !is null, "picture and/or font file(s) missing." );
	
	auto spr = new Bmp( 16, 16 );
	al_set_target_bitmap( spr() );
	//al_
	//al_draw_bitmap( , 0, 0 );
	
	al_set_target_bitmap( BMP );
	al_draw_filled_circle( 20, 20, 7, Colour.red );
	
	al_save_bitmap( "modify.jpg", BMP );
	
	al_set_target_bitmap( al_get_backbuffer( DISPLAY ) );
	
	float y = 20;
	bool exit = false;
	while(!exit)
	{
		ALLEGRO_EVENT event;
		while(al_get_next_event( QUEUE, &event))
		{
			switch(event.type)
			{
				case ALLEGRO_EVENT_DISPLAY_CLOSE:
				{
					exit = true;
					break;
				}
				case ALLEGRO_EVENT_KEY_DOWN:
				{
					switch(event.keyboard.keycode)
					{
						case ALLEGRO_KEY_ESCAPE:
						{
							exit = true;
							break;
						}
						default:
					}
					break;
				}
				case ALLEGRO_EVENT_MOUSE_BUTTON_DOWN:
				{
					exit = true;
					break;
				}
				default:
			}
		}

		if ( key[ ALLEGRO_KEY_M ] )
		{
			y += 1;
			break;
		}

		al_clear_to_color( ALLEGRO_COLOR(0.5, 0.25, 0.125, 1) );
		al_draw_bitmap( BMP, 50, 50, 0 );
		al_draw_triangle( 20, y + 20, 300, y + 30, 200, y + 200, ALLEGRO_COLOR( 1, 1, 1, 1 ), 4 );
		al_draw_text( FONT, ALLEGRO_COLOR( 1, 1, 1, 1 ), 70, 40, ALLEGRO_ALIGN_CENTRE, "Hello!" );
		al_flip_display;
	}
}
