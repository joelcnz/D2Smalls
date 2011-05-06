// This program makes the cpu (2 core) go up to a steady 100% when it normally is just 50%
import std.concurrency;

const infLoop = "for (;;) {}";

void main() {
	spawn(&infloop);
	mixin (infLoop);
}

void infloop() {
	mixin (infLoop);
}
