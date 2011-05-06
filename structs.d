struct Widget {
	private int[] array;
	this(uint length) {
		array = new int[length];
	}
	this(this) {
		array = array.dup;
	}
	int get(size_t offset) { return array[offset]; }
	void set(size_t offset, int value) { array[offset] = value; }
}

unittest {
	auto w1 = Widget(10);
	auto w2 = Widget(10);
	w1.set(5, 100);
	w2.set(5, 42);
	assert(w1.get(5) == 100);
}

void main() {}