// from ng Martin Kinkelin
import std.stdio;

void main() {}

struct A
{
    int[3] _data;
    string _name;

    this(string name) { writeln("A.__ctor() for ", name); _name = name; }
    ~this() { writeln("A.__dtor() for ", _name); }
    this(this) { _name ~= "2"; writeln("Postblit constructor for ", _name); }

    A dup()
    {
        A r = A(_name ~ ".dup");
        r._data[] = _data[];
        return r;
    }

    int opApply(int delegate(ref int) dg)
    {
        int r = 0;
        for (int i = 0; i < _data.length; i++)
        {
            r = dg(_data[i]);
            if (r)
                break;
        }
        return r;
    }
}

unittest
{
    A a = A("a");
    a._data = [ 1, 2, 3 ];

    writeln("Iterating through a:");
    foreach (ref e; a)
        writeln(e);

    writeln("\nIterating through a.dup:");
    {
        foreach (ref e; a.dup)
            writeln(e);
        writeln("ending inner scope");
    }
    writeln("inner scope ended");
}
