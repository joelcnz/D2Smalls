// ng.learn 26 Feb 2011
import std.stdio;

enum E { x, y, z, THE_END }

void main()
{
    foreach (e; E.min .. E.max) {
        writeln( e );
    }
}
