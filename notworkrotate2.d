// Org: Not mine
import std.stdio;
import std.datetime;
import std.array;
union Four {
        ubyte[4] bytes;
            uint num;
}
void main()
{
    ubyte[4] bytes1 = [1, 2, 3, 4];
    writef("%s\n", bytes1);
    bytes1 = bytes1[$-1] ~ bytes1[0..$-1];
    writef("%s\n", bytes1);
    bytes1 = bytes1[1..$] ~ bytes1[0];
    writef("%s\n", bytes1);

    ubyte[] bytes2 = [1, 2, 3, 4];
    writef("%s\n", bytes2);
    bytes2 = bytes2[$-1] ~ bytes2[0..$-1];
    writef("%s\n", bytes2);
    bytes2 = bytes2[1..$] ~ bytes2[0];
    writef("%s\n", bytes2);

    Four bytes3;
    bytes3.bytes = [1, 2, 3, 4];
    writef("%s\n", bytes3.bytes);
    bytes3.num = (bytes3.num << 8) | (bytes3.num >> 24);
    writef("%s\n", bytes3.bytes);
    bytes3.num = (bytes3.num << 24) | (bytes3.num >> 8);
    writef("%s\n", bytes3.bytes);

    size_t num2;
    Four bytes4;
    bytes4.bytes = [1, 2, 3, 4];
    writef("%s\n", bytes4.bytes);
    num2 = bytes4.num;
    asm {
        rol  num2, 8;
    }
    bytes4.num = num2;
    writef("%s\n", bytes4.bytes);
    num2 = bytes4.num;
    asm {
        rol  num2, 24;
    }
    bytes4.num = num2;
    writef("%s\n", bytes4.bytes);

    size_t iterations = 5_000_000;
    StopWatch timer;

    writef("Rotating static array left to right %d times\n", iterations);
    timer.start;
    foreach(i; 0..iterations)
    {
        bytes1 = bytes1[$-1] ~ bytes1[0..$-1];
    }
    timer.stop;
    writef("Finished in %10.2f msec\n", timer.peek().msec);
    timer.reset;

    writef("Rotating static array right to left %d times\n", iterations);
    timer.start;
    foreach(i; 0..iterations)
    {
        bytes1 = bytes1[1..$] ~ bytes1[0];
    }
    timer.stop;
    writef("Finished in %10.2f msec\n", timer.peek().msec);
    timer.reset;

    writef("Rotating dynamic array left to right %d times\n", iterations);
    timer.start;
    foreach(i; 0..iterations)
    {
        bytes2 = bytes2[$-1] ~ bytes2[0..$-1];
    }
    timer.stop;
    writef("Finished in %10.2f msec\n", timer.peek().msec);
    timer.reset;

    writef("Rotating dynamic array right to left %d times\n", iterations);
    timer.start;
    foreach(i; 0..iterations)
    {
        bytes2 = bytes2[1..$] ~ bytes2[0];
    }
    timer.stop;
    writef("Finished in %10.2f msec\n", timer.peek().msec);
    timer.reset;

    writef("Shifting Union left to right %d times\n", iterations);
    timer.start;
    foreach(i; 0..iterations)
    {
        bytes3.num = (bytes3.num << 8) | (bytes3.num >> 24);
    }
    timer.stop;
    writef("Finished in %10.2f msec\n", timer.peek().msec);
    timer.reset;

    writef("Shifting Union right to left %d times\n", iterations);
    timer.start;
    foreach(i; 0..iterations)
    {
        bytes3.num = (bytes3.num << 24) | (bytes3.num >> 8);
    }
    timer.stop;
    writef("Finished in %10.2f msec\n", timer.peek().msec);
    timer.reset;

    writef("Rolling Union left to right %d times\n", iterations);
    timer.start;
    foreach(i; 0..iterations)
    {
        num2 = bytes4.num;
        asm {
            rol  num2, 8;
        }
        bytes4.num = num2;
    }
    timer.stop;
    writef("Finished in %10.2f msec\n", timer.peek().msec);
    timer.reset;

    writef("Rolling Union right to left %d times\n", iterations);
    timer.start;
    foreach(i; 0..iterations)
    {
        num2 = bytes4.num;
        asm {
            rol  num2, 24;
        }
        bytes4.num = num2;
    }
    timer.stop;
    writef("Finished in %10.2f msec\n", timer.peek().msec);
    timer.reset;

    writef("Rolling Union left to right %d times with assignment with temporary variable outside of the loop\n", iterations);
    timer.start;
    num2 = bytes4.num;
    foreach(i; 0..iterations)
    {
        asm {
            rol  num2, 8;
        }
    }
    bytes4.num = num2;
    timer.stop;
    writef("Finished in %10.2f msec\n", timer.peek().msec);
    timer.reset;

    writef("Rolling Union right to left %d times with assignment with temporary variable outside of the loop\n", iterations);
    timer.start;
    num2 = bytes4.num;
    foreach(i; 0..iterations)
    {
        asm {
            rol  num2, 24;
        }
    }
    bytes4.num = num2;
    timer.stop;
    writef("Finished in %10.2f msec\n", timer.peek().msec);
    timer.reset;

}
/* Output:
[1, 2, 3, 4]
[4, 1, 2, 3]
[1, 2, 3, 4]
[1, 2, 3, 4]
[4, 1, 2, 3]
[1, 2, 3, 4]
[1, 2, 3, 4]
[4, 1, 2, 3]
[1, 2, 3, 4]
[1, 2, 3, 4]
[4, 1, 2, 3]
[1, 2, 3, 4]
Rotating static array left to right 5000000 times
Finished in    1992.81 msec
Rotating static array right to left 5000000 times
Finished in    2001.44 msec
Rotating dynamic array left to right 5000000 times
Finished in    1986.10 msec
Rotating dynamic array right to left 5000000 times
Finished in    1957.45 msec
Shifting Union left to right 5000000 times
Finished in      33.35 msec
Shifting Union right to left 5000000 times
Finished in      34.18 msec
Rolling Union left to right 5000000 times
Finished in      67.52 msec
Rolling Union right to left 5000000 times
Finished in      67.46 msec
*/
