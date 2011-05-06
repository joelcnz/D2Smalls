//#stuff goes here
/**
 * Title: Begin - the start of your program
 * 
 * Try: <program name> -h
 */
module begin; // or template for getting a new underway faster

pragma( lib, "liballegro5.lib" );
pragma( lib, "libdallegro5.lib" );
pragma( lib, "jeca.lib" );
pragma( lib, "misc.lib" );

import std.stdio;

import jeca.all;

void main( string[] args ) {
	scope( success ) { writeln( "Exit was successful." ); }
	
	// JECA init
	immutable succeed = 0;
	// could leave out the second parameter to the them all that way
	// the default res is 800x600
	if ( Init( args, ALLEGRO_INIT | TIMER | KEYBOARD | SOUND | GRAPHICS | MOUSE ) != succeed ) {
		return;
	}

	scope( exit )
		shutdown_input;
	
	KeyHandling keyHandling;
	
	while( ! keyHandling.keysAndExit ) {
	
		//#stuff goes here

		al_rest( 0.001 ) ;
	}
}

struct KeyHandling {
private:
	ALLEGRO_EVENT event;
	bool getNextEvent() {
		return al_get_next_event( QUEUE, &event );
	}
	immutable // over kill
		exitFalse = false,
		exitTrue = true;
public:
	auto keysAndExit() {

		poll_input; //#may be not needed after a library fix
		
		if ( key[ ALLEGRO_KEY_ESCAPE ] )
			return exitTrue;
		
		// keep going through current events till none left, in which case contiune
		while( getNextEvent )
		{
			switch( event.type )
			{
				// close button includes Alt + F4 etc
				case ALLEGRO_EVENT_DISPLAY_CLOSE:
					return exitTrue;
					
				default:
				break;
			}
		}
		
		return exitFalse;
	}
}
