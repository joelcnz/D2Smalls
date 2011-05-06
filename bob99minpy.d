// Not working - trying to do the Python minimin version converted to D
//By Oliver Xymoron (133 Bytes)

void main() {
	string a="%s bottles of beer on the wall";
	string t="Take one down, pass it around";
	for (int d=99; d>=0; d--) {
		writefln(a[(d % 2 ==0 ? $ - 12 : 0) .. $], d);
		writeln(t);print(a%d*2)[:-12]+t+a%(d-1 or'No')
	}
}