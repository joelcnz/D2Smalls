import allegro.allegro;

void main()
{
	allegro_init;
	install_keyboard;
	set_color_depth( 32 );
	set_gfx_mode( GFX_AUTODETECT_WINDOWED, 800, 600, 0, 0 );
	readkey;
}