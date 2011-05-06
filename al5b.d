import jeca.all;

void main() {
	scope( success ) {
		assert( 0, "success (not an error!)" );
	}
	Init([]);
}
