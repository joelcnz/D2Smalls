// Matthias Pleh - d.D.learn: Asm access to array (3 Feb 11);
// Me: animation
import std.stdio;

uint rotl_d(uint value,ubyte rotation){
    return (value<<rotation) | (value>>(value.sizeof*8 - rotation));
}

uint rotl_asm(uint value,ubyte rotation){
    asm{
        mov EAX, value;   // get first argument
        mov CL , rotation; // how many bits to move
        rol EAX, CL;
    }// return with result in EAX
}

void bin_writeln(string info,uint value, bool nl){
    writefln("%1s: %02$32b%3$s",info,value,nl?"\n":"");
}

int main(string[] argv){
    uint a=0xc0def00d;
    bin_writeln("value a",a           ,false);
    bin_writeln("value b",rotl_d(a,1),true);
    //
    bin_writeln("value a",a             ,false);
    bin_writeln("value b",rotl_asm(a,1),true);
	
	uint b;
	ubyte c = 0;
	while ( 1 == 1 ) { // Press Ctrl + C to quit
		b = rotl_asm(0xc0def00d, c);
		foreach (rst; 0 .. 5_000 )
			writef("%032b %2d\r",b, c );
		c = cast(ubyte)( c + 1 == 32 ? 0 : c + 1 );
		
	}
    return 0;
} 
