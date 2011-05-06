import std.string;
import std.c.stdlib;
import std.c.stdio;
import std.c.time;
import std.conv;

int xrand()
{
	static int lr = 0;
	lr = rand();
	srand(lr);
	return lr;
}

void genbt(int w, int h)
{
	int x,y,v;
	w *= 2;
	char[] s1, s2;
	s1.length = s2.length = w;
	
	printf("+");
	for(x = 0; x < w+1; x++)
		printf("-");
	printf("+\n");
	
	printf("|");
	for(x = 0; x < w+1; x++)
		printf(" ");
	printf("|\n");
	
	for(y = 0; y < h; y++)
	{
		for(x = 0; x < w;)
		{
			v = (xrand()>>3)&1;
			s1[x] = '#';
			s2[x++] = v ? ' ' : '#';
			s1[x] = v ? '#' : ' ';
			s2[x++] = ' ';
		}
		printf("| %s|\n| %s|\n",&s1[0],&s2[0]);
	}
	
	printf("+");
	for(x = 0; x < w+1; x++)
		printf("-");
	printf("+\n");
}

int main(string[] args)
{
	args ~= ["20","10"];
	srand(time(null));
	if(args.length <= 2) return 1;
	genbt(to!int(args[1]), to!int(args[2]));

	return 0;
}
