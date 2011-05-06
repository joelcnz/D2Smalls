@system:
import std.stdio;

//version = Fault;

class Transmogrifier
{
    double[512] alpha;
    size_t usedAlpha; // unused, hey! Look what's that-> (at the top of the source code)? Nothing, just doing random stuff (or trying to)
    
    this()
    {
		alpha[]=7; // fill all of the array with 7's
    }
}

void main()
{
    auto t = new Transmogrifier;
    writeln(t.alpha); 
	int a=void;
	double b=void;
	writeln("a=void => ", a, " double b=void =>", b);
	ubyte* p = void;
	writeln("Start");
	for(auto c=0; c < 100; c++, p++) {
		write((*p) % 100, ' '); // works
		version (Fault) {
			int size = (*p);
			foreach (h; 0 .. size) // causes a segmentation fault
				write("#");
			writeln();
		}
	}
	writeln("\r\nEnd");
}

