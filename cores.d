import std.stdio;
import core.cpuid;

void main() {
	writeln ("Cores per cpu: ", coresPerCPU);
	writeln ("vendor: ", vendor);
	writeln ("processor: ", processor);
	writeln ("model: ", model);
	writeln ("family: ", family);
	writeln ("isItanium? ", isItanium);
	writeln ("threadsPerCPU: ", threadsPerCPU);
}