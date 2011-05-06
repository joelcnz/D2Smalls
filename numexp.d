/*
//From 'The D program language' book
  Compute heights in centimeters for a range of heights
  expressed in feet and inches
*/
import std.stdio;

void main() {
  // values unlikely to change soon
  immutable inchPerFoot = 12;
  immutable cmPerInch = 2.54;

  // loop'n write
  foreach (feet; 5 .. 7) {
    foreach (inches; 0 .. inchPerFoot) {
      writeln(feet, "'", inches, "''\t",
        (feet * inchPerFoot + inches) * cmPerInch);
    }
  }
}
