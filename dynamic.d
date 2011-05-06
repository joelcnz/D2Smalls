/**
	Date: Aug 20, 2010
	This was copied from TDPL book pages 386 - 387 and later replaced by one on the digitalmars learn forum, then tampered by me.
*/
module dynamicmethods;

import std.stdio;
import std.conv;
import std.variant;

alias Variant delegate(Dynamic self, Variant[] args) DynMethod;

class Dynamic {
       private DynMethod[string] methods;
       void addMethod(string name, DynMethod m) {
               methods[name] = m;
       }
       void removeMethod(string name) {
               methods.remove(name);
       }
       // Dispatch dynamically on method
       Variant call(string methodName, Variant[] args) {
               return methods[methodName](this, args);
       }
       // Provide syntactic sugar with opDispatch
       Variant opDispatch(string m, Args...)(Args args) {
               Variant[] packedArgs = new Variant[args.length];
               foreach (i, arg; args) {
                       packedArgs[i] = Variant(arg);
               }
               return call(m, packedArgs);
       }
}

void main() {
       auto obj = new Dynamic;
       obj.addMethod("sayHello",
               (Dynamic, Variant[]) {
                       writeln("Hello, world!");
                       return Variant();
               });
       // m is just the previous anonymous delegate.
       DynMethod m = (Dynamic, Variant[]) {
                       writeln("Hello, world!");
                       return Variant();
                     };
       obj.sayHello(); // Prints "Hello, world!"
       // Now, what about a meta-method? test adds a bunch of methods in one go:
       obj.addMethod("test",
                     (Dynamic self, Variant[] args) {
                        writeln("the dynamic class currently has ", self.methods.length, " methods: ", self.methods.keys);
                        foreach(i,arg; args)
							self.addMethod("method"~to!string(i), arg.get!DynMethod);
                        writeln("Now, the dynamic class has ", self.methods.length, " methods: ", self.methods.keys);
                        return Variant();
                     });
        obj.test(m); // adds m to obj, as method0
        obj.method0(); // tests it. It prints "Hello, world!"
		obj.addMethod("bombsAndCrators", (Dynamic, Variant[]) {
							writeln("Bombs and Crators!-)");
							return Variant();
						});
		obj.bombsAndCrators;
}
