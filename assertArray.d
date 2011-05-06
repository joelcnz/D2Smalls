// 5 Sep 2010 - The D programming language (2.0)
import std.stdio;

void main(string[] args) {
     if (args.length > 1)
         writeln(args[1]);
     else
         writeln("No extra arguments");
     int[] nums;
     nums=[1,3,2];
     //int[] nums = [1,3,2]; // this works too, like the above
     assert(nums == [1,2,3]); // compare each element (I guess length first)
     readln;
}
