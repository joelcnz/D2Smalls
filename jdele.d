// Simple sample: how to use delegates within objects

import std.stdio;

// DelegateClass: a class with declared delegate function "printText"
class DelegateClass 
{
  public void delegate(char[] ) printText;
	public void delegate(char[],int ) printText2;
}

int main()
{
    // Function print
    void print(char[] text) { writefln(text); }
		void print2(char[] text,int number ) { writefln(text,number); }

    // Initialize a DelegateClass
    DelegateClass delclass = new DelegateClass();

    // Assign the delegate "printText" to function "print"
    delclass.printText = &print;
		delclass.printText2 = &print2;

    // Call printText to test

    delclass.printText(cast(char[])`Odd person: "HELLO Joel, how old are you today (July 2009)?"`);
    delclass.printText2(cast(char[])`Joel: "Age: %d"`,30);

    return 0;
}
