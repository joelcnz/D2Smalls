import std.stdio;

class OhTheJoy {
  auto opDispatch(string m, Args...)(Args args) {
    writeln("thanks for calling "~m~"!");
  }
}

void main(string[] args) {
  auto a = new OhTheJoy();
  a.new_method_name();
  a.otherMethodName();
}