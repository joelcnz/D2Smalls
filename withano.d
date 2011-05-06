// Org from stackoverflow web site - 3 Mar 2011
module withano;

class Foo { int x; }

void main()
{
    with (new Foo)
    {
        x = 5;
    }
}
