import std.stdio: writeln, writef;
import std.file: listdir, DirEntry;

void main(string[] args) {
	string[] files=getFiles(".");
	int col=4; // colloms or some thing
	int filePos=0;
	while (filePos<files.length) {
		foreach (c; 0 .. col) {
			writef("%-18s", files[filePos]);
			filePos++;
			if (filePos==files.length)
				break;
		}
		writeln("");
	}
}

string[] getFiles(string dir) {
	string[] files;
	bool callback(DirEntry* de)	{
	  if (! de.isdir)
		files~=de.name[2..$];
	  return true;
	}
	listdir(dir, &callback);

	return files;
}
