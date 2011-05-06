version (none) {
	m = 3 / (1/x + 1/y + 1/z);
	// versus:
	m = divide(3, add(add(divide(1, x),
	divide(1, y)), divide(1, z)));
}