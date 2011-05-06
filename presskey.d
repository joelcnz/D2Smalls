//Org found on stackoverflow - http://stackoverflow.com/questions/5372646/get-single-keystroke-in-d2-phobos
//#getch & 0xFF get number instead of character
import std.stdio : writefln;

//extern(C) int kbhit();
extern(C) int getch();

void main()
{
	writefln( "Press any key to continue." );
    //while(!kbhit())
    {
        // keep polling
        // might use Thread.Sleep here to avoid taxing the cpu.
    }

    writefln("Key hit was %S.", cast(char)getch); //#getch & 0xFF get number instead of character
}
