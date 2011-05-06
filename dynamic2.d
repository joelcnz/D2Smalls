import std.stdio;
import std.traits;
import std.variant;
import std.stdarg;
import std.conv;

interface StaticInterface {
	void a();
	void b(string);
}

void doSomething(StaticInterface d) {
	d.a();
	d.b("hello");
}

struct Dynamic {
	alias Dynamic delegate(Dynamic[] = null) DynamicFunction;

	DynamicFunction func;
	Variant var;

	bool isFunction;

	Dynamic*[string] properties;

	string toString() {
		if(isFunction)
			return "function";
		return to!string(var);
	}

	ref Dynamic opDispatch(string fieldName)(...) {
		if(_arguments.length == 0) {
			// a zero argument function call OR a getter....
			// we can't tell which for certain, so assume getter
			// since they can always use the call method on the returned
			// variable
			if(fieldName in properties)
				return *properties[fieldName];
			else {
				auto s = new Dynamic;
				properties[fieldName] = s;
				return *s;

				//throw new Exception("no such property: " ~ fieldName);
			}
		} else {
			// we have some kind of assignment, but no help from the
			// compiler to get the type of assignment...

			if(_arguments[0] == typeid(Dynamic)) {
				auto s = va_arg!(Dynamic)(_argptr);
				isFunction = s.isFunction;
				var = s.var;
				func = s.func;

				return this;
			}

			Variant v;

			string attempt(string type) {
				return `if(_arguments[0] == typeid(`~type~`)) v = va_arg!(`~type~`)(_argptr);`;
			}

			mixin(attempt("int"));
			mixin(attempt("string"));
			mixin(attempt("double"));
			mixin(attempt("real"));
			mixin(attempt("long"));

			auto s = new Dynamic;
			s.isFunction = false;
			s.var = v;

			properties[fieldName] = s;

			return *s;
		}
	}

	Dynamic opDispatch(string fieldName, T...)(T t) if(T.length != 0) {
		// trying to call a function
		Dynamic it = *properties[fieldName];
		return it.call(toDynamicArray(t));
	}

	Dynamic call(Dynamic[] args = null) {
		if(isFunction) {
			return func(args);
		}

		throw new Exception("trying to call something that isn't a function");
	}

	Dynamic[] toDynamicArray(T...)(T t) {
		Dynamic[] ret;

		foreach(v; t) {
			Dynamic s = *(new Dynamic);
			s = v;
			ret ~= s;
		}

		return ret;
	}

	Dynamic opAssign(T)(T t) {
		static if(isSomeFunction!T) {
			isFunction = true;
			func = makeDynamic(t);
		} else {
			isFunction = false;
			var = t;
		}

		return this;
	}



	// to call a zero argument function, you must use the call method to disambiguate from a getter

	T as(T)() if(!is(T == interface))  {
		if(isFunction)
			throw new Exception("this is a function idk what to do");

		return var.coerce!T;
	}

	T as(T)() if(is(T == interface))  {
		// FIXME: if it is a legitimate type that casts to it, give it up
		string impls() {
			string res;
			foreach(member; __traits(allMembers, T)) {
				T t;
				auto p = & __traits(getMember, t, member);
				//static if(__traits(isVirtualFunction, __traits(getMember, T, member))) {
					res ~= ReturnType!( p ).stringof
						~ " " ~ member ~ "(";

					string args;
					string magic;
					bool outputted = false;
					char cnt = 'a';
					foreach(arg; ParameterTypeTuple!(p)) {
						if(outputted) {
							args ~= ", ";
						} else
							outputted = true;

						args ~= arg.stringof ~ " _arglol" ~ cnt;

						magic ~= "holder = new Dynamic; *holder = _arglol" ~ cnt ~ "; args ~= *holder;";

						cnt++;
					}

					res ~= args;

					res ~= ") { Dynamic* holder; Dynamic[] args; "~magic~" return outer." ~ member ~ "().call(args); }";
				//}
			}

			return res;
		}

		mixin( `
			class Adapted : T {
				this(Dynamic* parent) { outer = parent; }
				Dynamic* outer;
		` ~ impls() ~ `}`);

		return new Adapted(&this);
	}

	DynamicFunction makeDynamic(T)(T t) {
		return delegate Dynamic(Dynamic[] args) {
			static if(isSomeFunction!(T)) {
				ParameterTypeTuple!(T) params;
				foreach(i, param; params) {
					if(i >= args.length)
						break;

					if(args[i].isFunction)
						throw new Exception("idk what tp do with a function");

					params[i] = args[i].var.coerce!(typeof(param));
				}
				t(params); // translate Dynamic[] into a T
			} else
				{}
			return Dynamic();
		};
	}
}

void main() {
	//auto s = new Dynamic;
	Dynamic s;

	s.a = "whoa";

	writeln(s.a);

	s.a() = {
		writeln("Hello, world!");
	} ;

	s.a().call;

	s.b() = delegate void(string a) {
		writeln("called with ", a);
	};

	doSomething(s.as!StaticInterface); // transform a dynamic object into a static interface!

	s.b("cool"); // can call the properties from D too

	s.a = "again a string";

	writeln(s.a.as!string);
}
