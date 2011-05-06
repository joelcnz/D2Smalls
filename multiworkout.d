import
	std.range,
	std.algorithm;

void main() {
	int[][] x = new int[][2];
	x[0] = [1, 2];
	x[1] = [3, 4];
	auto ror = frontTransversal(x);
	assert(equal(ror, [ 1, 3 ][]));
	
	auto y = new int[1][2];
	y[1][0] = 42;
	
	auto z = new int[][]( 1, 2 );
	z[0][1] = 42;
}
