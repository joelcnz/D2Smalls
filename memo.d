// Code from: http://ideone.com/q8lvf
// How do I test it?
private import std.traits, std.typecons;
 
public static auto memoStatic(alias Func)(ParameterTypeTuple!(Func) args)
{
        static ReturnType!(Func)[Tuple!(typeof(args))] cache;
        auto key = tuple(args);
        return key in cache ? cache[key] : (cache[key] = Func(args));
}
 
 
public static auto memoize(TFunc)(TFunc f) if (isCallable!(f))
{
        ReturnType!(TFunc)[Tuple!(TFunc, ParameterTypeTuple!(TFunc))] cache;
        return delegate(ParameterTypeTuple!(TFunc) args)
        {
                auto key = tuple(f, args);
                return key in cache ? cache[key] : (cache[key] = f(args));
        };
}
 
ulong fib(ulong n) { return n > 1 ? memoStatic!(fib)(n - 1) + memoStatic!(fib)(n - 2) : n; }
 
void main() { memoize(&fib); std.stdio.writefln("%d", fib(50)); }
