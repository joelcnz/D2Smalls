import std.stdio;
 
void main(string[] args) {
  int time = 0, x;
  for(int i = 0; i < 4; i++) {
    scanf("%d", &x);
    time += x;
  }
  writefln("%d", time/60);
}
	