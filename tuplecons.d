import std.stdio;
import std.typecons;
 
struct Foo {}
 
Tuple!(int, string, Foo) baz() {
    // some computation here
    return tuple(13, "inches", Foo());
}
 
void main() {
    auto bar = baz();
    assert(bar == tuple(13, "inches", Foo()));
    foreach( e; bar.expand )
		writeln( typeid( typeof( e ) ), ": ", e );
}
