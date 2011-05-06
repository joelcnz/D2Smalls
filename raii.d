import std.stdio;

version=one;
//version=another; //not work!

version(one) {
	class Foo{
			int k;
			this(int i){
			writefln("bin %d",k);
			k = i;
			}
			void doStuff(){
			writefln("do stuff %d",k);
			}
			void close(){
			writefln("close %d",k);
			}
	}
	struct RAII(T){
			T b;
			bool extracted = false;
			alias b this;
			this (T i){
			assert(i !is null);
			writeln("in");
			b = i;
			}
			~this(){
			writeln("~this");
			if(!extracted) b.close();
			}
			T extract(){
			assert(!extracted);
			T t = b;
			b = null;
			extracted = true;
			return t;
			}
	}
	RAII!(Foo) foo(int i){
			return RAII!(Foo)(new Foo(i));
	}
	void main(){
			auto a = foo(1);
			auto b = foo(2).extract();
			a.doStuff();
			b.doStuff();
	} 
}

version(another) {
	struct RAII(T : Object){
			T b;
			alias b this;
	
			void delegate(T) destroyer;
	
			this (T i, void delegate(T) called_at_exit){
					b = i;
					destroyer = called_at_exit;
			}
			~this(){
					if (b) destroyer(b);
			}
			T extract(){
					T t = b;
					b = null;
					return t;
			}
	}
	
	class Foo {
			this() { }
			void close() {
					writeln("closed.");
			}
	}
	
	RAII!Foo foo() {
			return RAII!Foo(new Foo, (Foo f) {f.close;});
	} 

	void main(){
			auto a = foo(1);
			auto b = foo(2).extract();
			a.doStuff();
			b.doStuff();
	} 
}
