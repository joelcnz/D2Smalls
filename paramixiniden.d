import std.stdio;

mixin template Box(T)
{
    T val;
}

mixin template MixinFields(P...)
{
    /* P[0] is the template to use as mixin
     * P[1] is the type to be use as parameter for P[0]
     * P[2] is the symbol name the mixin will be aliased to
     */
    mixin("mixin " ~ __traits(identifier, P[0]) ~ "!(" ~ P[1].stringof ~ ")
          " ~ P[2] ~ ";");
    static if(P.length > 3)
        mixin MixinFields!(P[0], P[3..$]);
}


class Set(T...)
{
    mixin MixinFields!(Box, T);
}

alias Set!(int, "a", int, "b") IntSet;

void main()
{
    scope auto s = new IntSet();
    s.a.val = 3;
	writeln("s.a.val: ", s.a.val);
}