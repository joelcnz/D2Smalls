import dmdscript.pretty;

import std.stdio;
import std.file;

	int fun() {
		writefln("Hello!");
		return 10;
	}

void raise() {
	throw new Exception("exception raised");
}

void fun2(string w) {
	writefln("Hello %s!", w);
}

void main(string[] args) {
	string buffer;

	auto se = new ScriptEngine;
	se.addDefaultFunctions();
	//se.addFunction!(fun);
	se.addFunction!(fun2);
	se.addFunction!(raise);

	auto g = se.globalObject;

	/* You can work with the script environment as an associative array... */
	g["hello"] = "Hello, world!";
	g["lol"] = new ScriptObject; // ScriptObject is just a generic object. You can specialize it in the constructor. 
	//g["lol"]["fun"] = &fun; // Can even assign native top-level functions this way!  FIXME: broken due to ICE

	/* Or, you can do it with opDispatch, though this is limited to just assigning existing ScriptObjects... */
	auto so2 = new ScriptObject;
	se.globalObject.lol.hate = so2;

	/* You can also add functions to specific ScriptObjects with the addFunction template */
	se.addFunction!(raise, "fun")(so2); 

	//se.addFunction!(read);

	if(args.length < 2) {
		foreach(line; stdin.byLine) {
			se.compile(line.idup);
			se.execute();
		}
	} else {
		foreach(arg; args[1..$]) {
			buffer ~= cast(string) std.file.read(arg);
		}
		se.compile(buffer);
		se.execute();
		// also try this:
		/*
		se.compile("function test(a) { println(a); }");
		se.call("test", 40);
		*/
	}
}
