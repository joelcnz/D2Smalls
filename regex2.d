//http://www.dsource.org/projects/tutorials/wiki/RegularExpressionsExample
import std.stdio : writefln;
import std.regexp;
import std.c.stdio;

bool isalpha(string c)
{
    RegExp myRegExp;    
    myRegExp = new RegExp("^[a-zA-Z_]+$", "");    
    return cast(bool) myRegExp.test(c);
}

bool isspace(string c)
{
     /* true if c is whitespace, false otherwise */

    RegExp myRegExp = new RegExp("^\\s+$", "");
    return cast(bool) myRegExp.test(c); 
}

bool isdigit(string c)
/* true if c is a decimal digit, false otherwise */
{
    RegExp myRegExp = new RegExp("^\\d+$", "");
    return cast(bool) myRegExp.test(c);
}

bool ishexdigit(string c)
/* true if c is a hexadecimal digit, false otherwise */
{
    RegExp myRegExp = new RegExp("^[0-9A-F]+$", "");
    /* If it were D code, "_" would also be valid */

    return cast(bool) myRegExp.test(c);
}

bool isoctdigit(string c)
/* true if c is an octal digit, false otherwise */
{
    RegExp myRegExp = new RegExp("^[0-7]+$", "");
    return cast(bool) myRegExp.test(c);
}

bool issymbol(string c)
/* true if c is legal SQL symbol, false otherwise */
{    
    RegExp myRegExp = new RegExp("^[\\(\\)\\[\\]\\.,;=<>\\+\\-\\*/&\\^]+$", "");
    return cast(bool) myRegExp.test(c);
}

unittest
{
    /* compile with the -unittest flag to run these tests */

    writefln("Testing functions...");
    
    assert(isalpha("a") && isalpha("A") && !isalpha("9") && isalpha("_") && isalpha("R") && !isalpha("&"));
    
    assert(issymbol("(") && issymbol(")") && issymbol("[") && issymbol("]") && issymbol(")") && 
      issymbol("[") && issymbol("]") && issymbol("-") && issymbol("/") && issymbol("=") && issymbol("*") && 
      issymbol(".") && !issymbol("a") && !issymbol("0") && !issymbol("Y") && !issymbol("\\"));
        
    assert(isdigit("0") && isdigit("7") && isdigit("9") && !isdigit("A")  && !isdigit("^") && !isdigit("G"));

    assert(ishexdigit("0") && ishexdigit("7") && ishexdigit("A")  && !ishexdigit("^") && !ishexdigit("G"));

    assert(isoctdigit("0") && isoctdigit("7") && !isoctdigit("8")  && !isoctdigit("A")  && !isoctdigit("^"));

    assert(isspace(" ")  && isspace("\t") && !isspace("o")  && !isspace(".")  && !isspace("5"));

    writefln("Functions tested successfully.");
}

void main()
{
    /* Compile with the -debug flag for this statement to run. */

    debug writefln("Main Program.");
}
