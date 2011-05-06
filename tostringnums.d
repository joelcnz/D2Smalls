// Got at the start from ng (learn) - Dmitry Olshansky 26 Feb 2011

import std.stdio,std.conv;
struct Numbers{
    float[] data;
    override string toString(){
        string result = "(";
        foreach(val;data[0..$-1]){
            result ~= to!string(val);
            result ~= ' ';
        }
        result ~= to!string(data[$-1]);
        result ~= ')';
        return result;
    }
    alias data this;
}

void main(){
    Numbers nums = Numbers([1.1,2.2,3.3]);
    writefln("%s",nums);
    nums[0] = 4.4;
    writefln("%s",nums);
}
