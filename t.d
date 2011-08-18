import std.string, std.algorithm, std.functional;

bool isANum( dchar chr ) {
	return inPattern( chr, digits ~ `"+-.` );
}

void main() {
    auto input = `abc123`;
    auto indexEnd = -1;

	indexEnd = count!( not!isANum )( input );
    assert( indexEnd == 3 );
}
