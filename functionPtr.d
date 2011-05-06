/**
	Date: 6 Sep 2010
	Origin: C# web site: http://www.codeproject.com/KB/cs/quickcsharp.aspx
*/
import std.stdio: writeln, writefln, readln;
import std.string: strip;
import std.conv: to;

int Add(int val1, int val2) 
{ 
	return val1 + val2; 
}

int Subtract (int val1, int val2) 
{ 
	return val1- val2;
}

void main()
{
	int function(int val1, int val2) Oper;

    writeln("Enter + or - ");
    string optor = getInput;
	writeln("["~optor~"]");

    writeln("Enter 2 operands");
	string opnd1, opnd2;
	auto inputs = [&opnd1, &opnd2];
	foreach (input; inputs)
		*input=getInput;
            
    int val1 = to!int(opnd1);            
    int val2 = to!int(opnd2);

    if (optor == "+")
        Oper = &Add;
    else
        Oper = &Subtract;
        
    writefln("Result = %s", Oper(val1, val2));
}

string getInput() {
	return readln[0 .. $ - 1]; // read user input, and remove the new line character (probably '\n')
}

/*
	string opnd1, opnd2;
	auto inputs = [&opnd1, &opnd2]; // or
	immutable(char)[]*[] inputs = [&opnd1, &opnd2]; // or
	string*[] inputs = [&opnd1, &opnd2];
	foreach (i; 0 .. 2)
		*inputs[i]=getInput;
*/