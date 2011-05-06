import std.stdio;
void main() {
	float f=0.01;
	float cents=f*100f;
	writefln("%0.2f->%d",f,cast(int)(cents));
	//writefln("%0.2f->%f",f,f*100f);
}
