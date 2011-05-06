//#not work
import std.stdio;

//#not work
template isVersion(string ver) {
     enum bool isVersion =3D !is(typeof({
           mixin("version(" ~ ver ~") static assert(0);");
     }));
}

static if (isVersion"VERSION1" || isVersion!"VERSION3") {
     writeln( "version is VERSION1 or VERSION3" );
} else {
	writeln( "version is not either VERSION1 or VERSION3" );
}

void main() { }
