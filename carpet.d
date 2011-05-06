// From d.D ng bearophile - 23-Feb-11 3:28 pm

import std.stdio, std.string, std.algorithm, std.array, std.range;
 
string[] nextCarpet(string[] c) {
    auto b = array(map!q{a ~ a ~ a}(c));
    return b ~ array(map!q{a ~ a.replace("#"," ") ~ a}(c)) ~ b;
}
 
void main() {
    auto c = recurrence!((a, n){ return nextCarpet(a[n-1]); })(["#"]);
    writeln(array(take(c, 4)).back.join("\n"));
}
