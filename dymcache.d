//In connection with stack over flow. Code copy from: https://gist.github.com/741782#file_memoize.d (version (Old) stuff)
import std.traits, std.typecons;

//version = Old;

auto memoize(TFunc)(TFunc fn)
{
	static ReturnType!(TFunc)[Tuple!(TFunc, ParameterTypeTuple!(TFunc))] cache;
	return delegate(ParameterTypeTuple!(TFunc) args)
	{ auto k = tuple(fn, args); return k in cache ? cache[k] : (cache[k] = fn(args)); };
}

version (Old) ulong fib(ulong n) { return n > 1 ? fib(n - 1) + fib(n - 2) : n; }
else ulong fib(ulong n) { return n > 1 ? memoize(&fib)(n - 1) + memoize(&fib)(n - 2) : n; }

void main() { std.stdio.writefln("%d", fib(7_000)); }
