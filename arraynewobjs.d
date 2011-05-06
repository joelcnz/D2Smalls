void main() {
	auto list = [ cast( A )new B, new C, new B ];
}

abstract class A { }

class B : A { }

class C : A { }
