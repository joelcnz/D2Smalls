/**
	05.08.2010
*/
//# donkey plops!
import std.stdio;
import jec2.all;

void main(string[] args) {
	Init(args);
	install_sound_input(DIGI_AUTODETECT, DIGI_NONE);
	set_sound_input_source(SOUND_INPUT_MIC);
	int bits=get_sound_input_cap_bits;
	int stereo=get_sound_input_cap_stereo;
	int rate=get_sound_input_cap_rate(bits, stereo);
	int loop=0; // 0 - false, 1 - true
	start_sound_input(rate, bits, stereo);
	SAMPLE* sample=create_sample(bits,stereo,rate,loop);
	writeln("bits=", bits, " stereo=", stereo, " rate=", rate, " loop=", (1==1 ? "true" : "false"));
	ubyte* buf=cast(ubyte*)sample.data;
	debug (5)
		int count=0;
	while (! (key[KEY_SPACE] || key[KEY_ESC])) { // while either space and esc not pressed
		if (read_sound_input(buf) != 0) {
			writeln("All loaded up!");
			debug (5)
				count=0-1;
		}
		rest(10);
		debug (5)
			write(count++, " ");
	}
	stop_sound_input;
	play_sample(sample, 255, 128, 1000, 1);
	readkey;
}
