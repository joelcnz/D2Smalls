import std.typecons: tuple;
import std.c.stdio: printf;

auto foo() {
    printf("foo\n");
    return tuple(1, 2);
}

void main() {
    foreach (x; foo().tupleof)
        printf("%d\n", x);
}

/*
output:
1
foo
2
*/
