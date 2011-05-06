//http://ideone.com/qmgf1Fc1
import std.stdio;
import std.string;

void main() {
 T[] makeArray(T)(T start,T end) {
  T[] a;
  foreach(i; start .. end + 1)
   a ~= i;
  return a;
 }

 int[] ai = makeArray!int(0,7); // (0,7) - inclusive
 float[] af = makeArray!float(0.5,7.5);

 void test(T)(T[] arr) {
  void show() {
   writeln(arr);
  }
  show;
  insert!(T)(arr,3,is(T == char) ? 'D' : 50);
  show;
 }
 test!int(ai);
 test!float(af);
 test!char("abcdefghijklmnopqrstuvwxyz".dup);
 char[] alphabet="abcdefghijklmnopqrstuvwxyz".dup;
 alias alphabet a;
 a[a.indexOf('j')] = 'J';
 writeln(insertArray!char(alphabet,10,"oeL".dup));
}

void insert(T)(ref T[] arr,int i,T e) {
  arr = arr[0 .. i] ~ e ~ arr[i .. $];
}

auto insertArray(T)(T[] arr,int i,T[] es) {
  arr = arr[0 .. i] ~ es ~ arr[i .. $];
 return arr;
}

