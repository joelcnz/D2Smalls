// From StackOverFlow I altered it to compile (changed bytes to ints). 
import std.stdio;
pragma(msg,"hello world");
//a delegate type
alias int delegate(int) int_dg;
void main (string[] args){
  //Function literals!
  int_dg dg = delegate(int x){ return x*x; };
  writefln("dg(2) = %d",dg(2));
  //Functions that return functions
  int_dg del = tricky(dg);
  writefln("del(2) = %d",del(2));
  uint crazy (uint a) {
      if (a < 20){
      return a+12;
      }else{
      return a-12;
      }
  }
  //Metaprogramming with templates and delegtates wooho
  writefln("Sh!(ubyte).tricky(&crazy)(2) = %d",Sh!(uint).tricky(&crazy)(2));
  writeln(typeid(DgTup!(DgTup!(int))));
  //Tuples
  alias Tuple!(int,float,3) E;
  //Template mixins
  mixin MixMe!(E[0]);
  x = E[2];
  writeln(x);
}
int_dg tricky (int_dg dg){
  return delegate(int d){ return dg(dg(d+d+d)); };
}
template Sh (T){
    DgTup!(T) tricky (DgTup!(T) dg){
    return delegate(T d){ return dg(dg(d+d+d)); };
    }
}
template Tuple(E...){
    alias E Tuple;
}
template DgTup(T){
    alias T delegate(T) DgTup;
}

template MixMe(T)
{
    T x = 5;
}
