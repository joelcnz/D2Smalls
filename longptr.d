import std.stdio;

void Foo(T:T*)(T arg) if(!is(T==int)) {
  writeln("arg of Foo:", arg, typeid(T));
}
void Foo(T:T*)(T arg) if(is(T==int)) {
  writeln("int Foo!");
}

void main() {
  Foo!(long*)(54L);
}
