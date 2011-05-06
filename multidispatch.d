//Org: Adam D. Ruppe: destructionator@gmail.com

import std.stdio;
import std.traits;

template implementMultipleDispatch(alias Class, alias method) {
	//pragma(msg, multipleDispatchImpl!(Class, method,
	//	__traits(identifier, method))());

        // mixing it in right here didn't work for some reason
	alias multipleDispatchImpl!(Class, method,
		__traits(identifier, method)) implementMultipleDispatch;

}

// straight stringof hit a problem with forward reference, so this hack will
// do it

string[] parameterTypeStrings(string methodString)() {
	string[] ret;

	int startingAt;
	int state = 0;
	foreach(idx, c; methodString) {
		switch(state) {
			// first, we find the opening param
			case 0:
				if(c == '(') {
					state++;
					startingAt = idx + 1;
				}
			break;
			case 1: // we're reading a type name
				if(c == ' ') {
					// just finished
					ret ~= methodString[startingAt .. idx];
					state = 2;
				}
			break;
			case 2: // now we're reading a name
				if(c == ' ') {
					state = 1; // another type
					startingAt = idx + 1;
				}
				if(c == ')') // we're done
					//break loop;
					state = 3;
			break;
			// we're done, but break loop doesn't work in CTFT
			case 3: // do nothing with the rest
		}
	}

	return ret;
}

string multipleDispatchImpl(alias Class, alias method, string methodName)() {
	string code = `void ` ~ methodName ~ `(`;

	alias typeof(__traits(getOverloads, Class, methodName)) overloads;

	string baseType = Class.stringof;
	bool outputted = false;

	// we'll reuse the call string to make our calls
	string call = methodName ~ "(";
	char arg_char = 'a';
	foreach(arg; ParameterTypeTuple!(method)) {
		if(outputted) {
			code ~= ", ";
			call ~= ", ";
		} else
			outputted = true;

		code ~= baseType ~ " " ~ arg_char;
		call ~= " " ~ arg_char ~ "_casted";
		arg_char++;
	}

	call ~= ");";
	code ~= ") {";

	foreach(overload; overloads) {

		code ~= "{"; // we'll introduce a scope to do our casts
		string ifCheck; // this lists the checks for null
		outputted = false;
		arg_char = 'a';

		foreach(argument; parameterTypeStrings!(overload.stringof)) {
			// just try to cast all of them
			code ~= "auto ";
			code ~= arg_char ~ "_casted = cast(";

			code ~= argument;

			code ~= ") " ~ arg_char ~ ";";

			if(outputted)
				ifCheck ~= " && ";
			else
				outputted = true;

			ifCheck ~= arg_char ~ "_casted !is null";

			arg_char++;
		}

		// if none of the args are null, it's safe to do the call
		code ~= "if(" ~ ifCheck ~ ") {";
		code ~= call ~ "return;"; // return because we're done
		code ~= "}"; // end if
		code ~= "}"; // close our casting scope
	}

	code ~= "}";

	return code;
}

class A : Base {}
class B : Base {}

class Base {
	void multipleDispatchFun(A a, A b) { writeln("Called (A, A)"); }
	void multipleDispatchFun(A a, B b) { writeln("Called (A, B)"); }
	void multipleDispatchFun(B a, B b) { writeln("Called (B, B)"); }

	mixin (implementMultipleDispatch!(typeof(this), multipleDispatchFun));
}


void main() {
	Base base = new Base();
	Base a = new A();
	Base b = new B();

        // calls the generated base class overload
	base.multipleDispatchFun(a, a);
	base.multipleDispatchFun(a, b);
	base.multipleDispatchFun(b, b);

	readln;
        // and, of course, if the static types are known, the
        // regular overload works fine. only problem is if one
        // is statically known and one is not. Then you shoud
        // cast to the base type manually so it triggers the
        // generated overload
}

