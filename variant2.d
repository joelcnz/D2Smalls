/// Got this out of a D forum juanjux@thatwebmailofgoogleproperty.com
import std.variant;
import std.stdio;

class C
{
    bool test(int i, char c) { writeln("Hello from test1"); return true; }
    void test2(string v) { writeln("Hello from test2, ", v); }
}

void main()
{
    auto c = new C;
    Variant[string] holder = ["test": Variant(&c.test), "test2": Variant(&c.test2)];
    receiver(holder);
}

void receiver(Variant[string] message) 
{
    // If you get the Variant template instantiation delegate 
    // signature wrong, it will
    // be detected at compile time!
    auto t = message["test"].get!(bool delegate(int, char));
    auto t2 = message["test2"].get!(void delegate(string));
    t(1, 'c');
    t2("foo");
}
