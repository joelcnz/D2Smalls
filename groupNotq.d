//Org: bearophile d.learn 9 May 2011
import std.stdio, std.algorithm;

void main() {
    auto arr = [ 64, 64, 64, 32, 31, 16, 32, 33, 64 ];

    int last = 0;
    foreach( g; group!q{ ( a < 32) == ( b < 32 ) }( arr ) ) {
        writeln( arr[ last .. last + g[ 1 ] ] );
        last += g[ 1 ];
    }
}
