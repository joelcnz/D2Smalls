//#These to normally commented out
/*
	Copyright (C) 2004 Christopher E. Miller
	
	This software is provided 'as-is', without any express or implied
	warranty.  In no event will the authors be held liable for any damages
	arising from the use of this software.
	
	Permission is granted to anyone to use this software for any purpose,
	including commercial applications, and to alter it and redistribute it
	freely, subject to the following restrictions:
	
	1. The origin of this software must not be misrepresented; you must not
	   claim that you wrote the original software. If you use this software
	   in a product, an acknowledgment in the product documentation would be
	   appreciated but is not required.
	2. Altered source versions must be plainly marked as such, and must not be
	   misrepresented as being the original software.
	3. This notice may not be removed or altered from any source distribution.
*/
module wildcard.wildcard;

import std.stdio;
import std.ctype;

//#These to normally commented out
// debug = WILDCARD; //show all tests as it's happening (recursion)
// version = WILDTEST; //has main function and prompts for testing the function


debug(WILDCARD)
	import std.stream;


bool wildMatch(string wild, string str)
{
	debug(WILDCARD)
		writeln("wildMatch(\"" ~ wild ~ "\", \"" ~ str ~ "\")");
	
	uint wi, stri;
	for(stri = wi = 0; wi != wild.length; wi++)
	{
		switch(wild[wi])
		{
			case '*':
				if(wi == wild.length - 1)
					return true;
				
				wild = wild[++wi .. wild.length];
				for(; stri != str.length + 1; stri++)
				{
					if(wildMatch(wild, str[stri .. str.length]))
						return true;
				}
				return false;
			
			case '?':
				if(++stri > str.length)
					return wi == wild.length - 1;
				break;
			
			default:
				if(stri >= str.length)
					return false;
				
				if(std.ctype.tolower(cast(dchar)wild[wi]) != std.ctype.tolower(cast(dchar)str[stri]))
					return false;
				stri++;
		}
	}
	
	return stri == str.length;
}


unittest
{
	assert(wildMatch("Foo", "foo"));
	assert(wildMatch("f?o", "foo"));
	assert(wildMatch("f*", "foo"));
	assert(wildMatch("*", "foo"));
	assert(!wildMatch("f?", "foo"));
	assert(wildMatch("f?*o", "foo"));
	assert(wildMatch("?", "i"));
	assert(wildMatch("*world", "hello world"));
	assert(wildMatch("hello*d", "hello world"));
}


version(WILDTEST)
{
	import std.stream, std.string;
	
	int main()
	{
		for(;;)
		{
			writeln("\nThe wildcard tester (type QUIT to leave)!\n\nEnter a string> ");
			string str;
			stdin.readln(str);
			if(!icmp(str, "QUIT"))
				break;
			
			write("Now a wildcard string> ");
			string wild;
			stdin.readln(wild);
			
			if(wildMatch(wild, str))
				writeln("They match!");
			else
				writeln("They do NOT match :(");
		}
		
		return 0;
	}
}

