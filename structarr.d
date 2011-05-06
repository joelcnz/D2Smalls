struct MyStruct(T : T[], T a) {
    void test() {
		T A = a.dup;
		writeln( A );
	}
}

void main() {
	MyStruct!(string, "rabbit") s;
	
}
