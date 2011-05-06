import std.c.stdio;

void main(string[] args)
{
	string filename = args.length > 1 ? args[1].idup : "test.bin";
	
	FILE* pFile;
	pFile = fopen(filename.ptr, "rb");
	fseek(pFile, 0, SEEK_END);
	int size = ftell (pFile);
	rewind(pFile);
	
	char[] buffer;
	buffer.length = size;
	fread(buffer.ptr, 1, size, pFile);
	foreach (i, d; buffer)
		printf("%hd%.*s", cast(ubyte)d, i != size - 1 ? ", " : "" );
}
