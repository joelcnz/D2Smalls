/**
	Date: 6 Sep 2010
	Origin: C# web site: http://www.codeproject.com/KB/cs/quickcsharp.aspx
*/
import std.stdio: writeln, writefln, readln;
import std.string: strip;
import std.conv: to;

void main()
{
	int Add(int val1, int val2) 
	{ 
		return val1 + val2; 
	}
	int Subtract (int val1, int val2) 
	{ 
		return val1 - val2;
	}

	int delegate(int val1, int val2) Oper;

    writeln("Enter + or - ");
    string optor = strip(readln());
    writeln("Enter 2 operands");
            
    string opnd1 = strip(readln());
    string opnd2 = strip(readln());
            
    int val1 = to!int(opnd1);            
    int val2 = to!int(opnd2);

    if (optor == "+")
        Oper = &Add;
    else
        Oper = &Subtract;
        
    writefln("Result = %s", Oper(val1, val2));
}
