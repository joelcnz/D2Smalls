//#msecs
//#mucked up the program so it won't exit like normal or do any thing
//#is a shorter version
//#draw on spr here
module testjeca;

version = AwfulSlow; // note: not fun to exit, actually not fun any way

version( Windows ) {
	pragma( lib, "liballegro5" );
	pragma( lib, "libdallegro5" );
	pragma( lib, "libjeca" );
}

version( linux ) {
	pragma( lib, "allegro" );
	pragma( lib, "allegro_primitives" );
	pragma( lib, "allegro_ttf" );
	pragma( lib, "allegro_font" );
	pragma( lib, "allegro_image" );
	pragma( lib, "allegro_audio" );
	pragma( lib, "allegro_acodec" );

	pragma( lib, "jeca" );

	pragma( lib, "dallegro5" );
}

import std.stdio;
import std.string;
import std.datetime;

import jeca.all;

void main( string[] args ) {
	if ( args.length != 4 ) {
		writeln( "test <ttf name> <picture file name> <sound file name>" );
		writeln( "Defaulting to: test DejaVuSans.ttf mysha.pcx fire.wav" );
		args ~= "DejaVuSans.ttf mysha.pcx fire.wav".split();
	}

	try {
		Init( args ); //[ "-mode window -wxh 800 600" ] );
	} catch( Exception e ) {
		writeln( "Caught in test.d in main: " ~ e.toString );
	}
	scope( exit ) Deinit( "Farewell.." );
	
version( none ) {
	writeln( "Press any key to continue" );
	readkey;
}

	string loadTest( in string lhs, in string rhs ) {
		return
			lhs ~ ` = ` ~ rhs ~ `; `
			`if (` ~ lhs ~ ` !is null ) {`
				`writeln( "loading ` ~ `", ": passed" ); `
			`} `
			`else `
				`writeln( "` ~ lhs ~ `", ": failed" ); `;
	}
	
	//mixin( loadTest( "FONT", `al_load_font("DejaVuSans.ttf", 18, 0)` ) );
	mixin( loadTest( "FONT", `al_load_font( toStringz( args[1] ), 18, 0)` ) );
	//FONT = al_load_font("DejaVuSans.ttf", 18, 0);
	auto pic = al_load_bitmap( toStringz( args[ 2 ] ) );
	auto snd = new Snd( args[ 3 ] );
//	auto snd = al_load_sample( toStringz( args[ 3 ] ) );
	
	assert( snd !is null && pic !is null && FONT !is null, "media missing or failed." );

	auto spr = new Bmp( 16, 16 );
	al_set_target_bitmap( spr() );
	
	//#draw on spr here
	
	al_set_target_bitmap( al_get_backbuffer( DISPLAY ) ); //#is a shorter version
	float y = 0f;

	ALLEGRO_BITMAP* stamp = al_create_bitmap( SCX, SCY );
	
	writeln( "Help:\nEscape to exit\ncursor down to move triangle\nEnter for sound" );
	bool exit = false;
	while( ! exit )
	{
		StopWatch sw;
		sw.start;
		do {
			poll_input;
			
			ALLEGRO_EVENT event;
			while( al_get_next_event( QUEUE, &event ) )
			{
				switch(event.type)
				{
					// close button includes Alt + F4
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
							case ALLEGRO_KEY_DOWN: y += 10; break;
							case ALLEGRO_KEY_ENTER:
								writeln( "Lets hear it!" );
								snd.play(); // stops all the snd sounds
								break;
							case ALLEGRO_KEY_BACKSPACE:
								snd.stop();
							break;
							default:
							break;
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
			if ( key[ ALLEGRO_KEY_D ] )
				++y;
//			writeln( "Time: ", sw.peek().hnsecs );
//#msecs
		} while( sw.peek().hnsecs < 100 );


		al_set_target_bitmap( stamp );
		version( AwfulSlow ) {
			//#mucked up the program so it won't exit like normal or do any thing
			foreach( py; 0 .. SCY )
				foreach( px; 0 .. SCX ) 
					al_draw_pixel( px, py, Colour.black );
					//al_draw_pixel( px, py, Colour.black );
		}
		else
			al_clear_to_color( ALLEGRO_COLOR(0.5, 0.25, 0.125, 1) );

		al_draw_bitmap( pic, 50, 50, 0 );
		al_draw_triangle( 20, y + 20, 300, y + 30, 200, y + 200, ALLEGRO_COLOR( 1, 1, 1, 1 ), 4 );
		al_draw_text(
			FONT,
			ALLEGRO_COLOR( 1, 1, 1, 1 ),
			70, 40,
			ALLEGRO_ALIGN_CENTRE, toStringz( format( "y = %s", y ) )
		);
		al_set_target_bitmap( al_get_backbuffer( DISPLAY ) );
		al_draw_bitmap( stamp, 0, 0, 0 );

		al_flip_display;
		
		al_rest( 0.01 );
	}
}
