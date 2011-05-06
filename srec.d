/**
	05.08.2010
*/
import std.stdio;
import std.string;
import std.stream;
import jec2.all;

void main(string[] args) {
	Init(args);
	install_sound_input(DIGI_AUTODETECT, MIDI_NONE);

   int ofs = 0;
   int len;
   int size;
   int foo;
   int rate = 44100;
   int result = 0;
   SAMPLE* sample;
   int interval;
   void *buf;
   
   result = get_sound_input_cap_parm(rate, 16, 0);    
   set_volume(255,255);
   
   if (result < 0) {
       rate = result *-1;
   } else if (rate == 0) {
       return;
   }
   writef("rate = %s\n", rate);
   size = 1024*1024;
   sample = create_sample(16, 0, rate, size);
   buf = sample.data;
   
   
   set_sound_input_source(1);
   len = start_sound_input(rate, 16, 0);
   
   /* calc max interval */
   interval = 1000 / ((len / 2) / rate);
   
   /* use 9/10 of the max intervall */
   interval *= 9;
   interval /= 10;
   
   textprintf_ex(screen, font, 0, SCREEN_H/2, Colour.amber, 0, toStringz("Hit space, say your thing, then hit space again"));
	readkey;
	alclear(screen);
   writefln("len=%s, intervall=%s", len, interval);
   while (!keypressed() && ofs < size) {
       foo = read_sound_input(buf);        
       if (foo > 0) {
           ofs += len;
           buf += len;
           writefln("%s", foo);
       }
       rest(interval);
   }
   if (keypressed()) {
       foo = read_sound_input(buf);        
       if (foo > 0) {
           ofs += len;
           buf += len;
           writefln("%s", foo);
       }
   }
   stop_sound_input();
   clear_keybuf();    
   version (all) {
	do {
		play_sample(sample, 255, 128, 1000,0);
		writeln("Enter y, to play again");
	} while( getInput[0]=='y' );

	version (Saving) {
		write("Save sample y/n: ");
		string save=getInput;
		if (save[0]=='y') {
			write("Enter file name (with out extenstion): ");
//		OutputStream fin
//		writeBlock(
		}
	} // Saving
	} // version all
}

string getInput() {
	return strip(readln);
}
