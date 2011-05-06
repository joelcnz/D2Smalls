import std.stdio;
import std.array: popFront;
void main() {
    auto d = [1:[2, 3]];
    auto l = d[1];
    auto l2 = l[0];
    l.popFront();
    writeln(d, "  ", l, "  ", l2);
}

/*
# Python
d = {1:[2, 3]}
l = d[1]
l2 = l.pop(0)
print d, "", l, "", l2
*/