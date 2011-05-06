/// Title: Morris Powers
/**
 * Showing Morris a bit of programming
 */
module morrispow;

import std.stdio;


/// Title: Main
/**
 * Declare a string of charactors variable with the name "Morris"
 * print the value of name to the console.
 */
/// Declare integers with the identifiers(sp) a, b, and c.
/// Set a, and b with 3 and 7 respectively. Print the values of a and b
/// Set c to a to the power of 2. Print c value
void main() {
	string name; // declare name as a string type
	name = "Morris"; // assign a string to the name variable
	writeln(name); // print name's value

	int a, b, c; // declare 3 variables as integers
	a=3; // assign a number
	b=7; // assign another number
	writeln(a, ' ', b);
	
	c = a ^^ 2; // a to the power of 2
	writeln("c=", c);
}
