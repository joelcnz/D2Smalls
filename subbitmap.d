import jec2.all;

void main( string[] args ) {
	Init( args );
	
	BITMAP* bmp = create_sub_bitmap( screen, 100, 50, 640, 480 );
	
	
	
	destroy_bitmap( bmp );
}
