#!dmd -w -debug -run php.d
// Got this from d.D news group: Kagamin 21 Nov 2010 10:46am
module phpTest;
import std.string, std.conv;
debug import std.stdio;

mixin Php!(phpTest); //usage

string sval="ab128#d";
int ival=274;

int main()
{
	string tpl=`asdf \{sval} astt35 \{ival} zzf \{uuu} g,d`;
	debug writeln(tpl);
	debug writeln(phpString(tpl));
	return 0;
}

mixin template Php(alias Mod)
{
	string phpString(string fmt)
	{
		string[] buff;
		string rem=fmt;
		while(rem.length)
		{
			auto spos=rem.indexOf('\\'); //position of slash
			if(spos>=0)
			{
				if(spos+2<rem.length && rem[spos+1]=='{')
				{
					const rem1=rem[spos+2..$]; //after brace
					auto end=rem1.indexOf('}');
					if(end>=0)
					{
						string expr=rem1[0..end];
						expr=phpEval(expr);
						buff~=rem[0..spos]; //up to slash
						buff~=expr; //instead of escape sequence
						rem=rem1[end+1..$]; //after escape sequence
						continue;
					}
				}
			}
			buff~=rem;
			break;
		}
		string r;
		foreach(s;buff)r~=s;
		return r;
	}

	string phpEval(string expr)
	{
		foreach(string m;__traits(allMembers,Mod))
		{
			if(m==expr)
			{
				enum string txt="text("~__traits(identifier,Mod)~'.'~m~")";
				enum string retmem="return "~txt~";";
				enum string retm="return m;";
				mixin("enum bool canReturn=is(typeof("~txt~")==string);");
				enum string sret=canReturn?retmem:retm;
				mixin(sret);
			}
		}
		return expr;
	}
}