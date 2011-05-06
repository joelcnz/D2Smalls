import std.variant;
import std.stdio;

alias Variant delegate(Dynamic self, Variant[] args) DynMethod;

class Dynamic  {
    private DynMethod[string] methods;

    final void addMethod(string name, DynMethod m) {
        methods[name] = m;
    }
    final void removeMethod(string name) {
        methods.remove(name);
    }
    // Dispatch dynamically on method
    final Variant call(string methodName, Variant[] args) {
        return methods[methodName](this, args);
    }
    // Provide syntactic sugar with opDispatch
    Variant opDispatch(string m, Args ...)(Args args) {
        Variant[] packedArgs = new Variant[args.length];
        foreach (i, arg; args) {
            packedArgs[i] = Variant(arg);
        }
        return call(m, packedArgs);
    }
}

class MyClass : Dynamic {
    package int a = 0;

    void showA() {
        writeln("a is ", a);
    }
}

int main (string[] args) {
    auto obj = new MyClass;

    obj.addMethod(  "myBrandNewMethod",
                    delegate Variant (Dynamic d, Variant[] args) {
                        foreach(i, arg; args) {
                            writeln("arg[", i, "] = ", arg);
                        }
                        return Variant(0);
                    });

    obj.addMethod(  "sayHello",
                    delegate Variant (Dynamic d, Variant[] args) {
                        writeln("Hello world!");
                        (cast(MyClass)d).a = 23;
                        return Variant(0);
                    });

    obj.myBrandNewMethod("wat", 1, 3.141592);
    obj.sayHello();
    obj.showA();

    return 0;
}
