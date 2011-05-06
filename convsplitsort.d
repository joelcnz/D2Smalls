import std.stdio;
import std.string;
import std.conv;
 
void main() {
  string namestmp = "Joel Luke Timothy Chris Hamish";
  auto names = split(namestmp);
  auto longest = 0;
  for (int i = 0; i < names.length; i++) {
    if (names[i].length > longest)
      longest = names[i].length;
    for (int i2 = i + 1; i2 < names.length; i2++)
      if (names[i].length > names[i2].length) {
        auto tmp = names[i];
        names[i] = names[i2];
        names[i2] = tmp;
      }
  }
  auto form = "%" ~ to!(string, int)(longest) ~ "s :%s";
  foreach (name; names)
    writefln(form, name, name.length);
}
