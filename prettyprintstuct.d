//Org: s.newsgroup: Andrej Mitrovic 25 4 2011
//#would've though 1 and not 3
import std.stdio;
import std.string;

void main()
{
    struct ASIOChannelInfo
    {
        int channel;
        int isInput;
        int isActive;
        int channelGroup;
        int type;
        string name;
    }

    auto info = ASIOChannelInfo(1, 1, 1, 16, 32, "Analog OUT");

    auto fields = __traits(allMembers, typeof(info));
    auto values = info.tupleof;

	int maxWidth = 0;
	foreach ( fieldv; values) {
		string field = format("%s", fieldv );
		if ( field.length > maxWidth )
			maxWidth = field.length;
	}
	maxWidth += 3; //#would've thought 1 and not 3
	
    foreach (index, value; values)
    {
        string field = format("%s", fields[ index ] );
        write( field );
        foreach( space; 0 .. maxWidth - field.length )
			write( index % 2 ? (space % 2 ? ' ' : '-') : ' ' );
        writeln( value );
    }
}
