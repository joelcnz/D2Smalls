module testlib;
import std.stdio, std.string;

class classtest {

  int i, j;

  double[][] hit() {

    double[][] hi = new double[][](1000, 40);

    for(i = 1; i < 1000; i++) {
      for(j = 1; j < 40; j++) {
        hi[i][j] = (i);
      }
    }
    return hi;
  }

  double[][] hot() {

    double[][] ho = new double[][](1000, 40);

    for(i = 1; i < 1000; i++) {
      for(j = 1; j < 40; j++) {
        ho[i][j] = (j);
      }
    }
    return ho;
  }

  string stest () {
    string hello = "yo!";
    return hello;
  }
}

import std.stdio, std.string;
import testlib;

void main() {

  classtest obj = new classtest;
  int i, j;

  for(i = 1; i < obj.hit.length; i++) {
    for(j = 1; j < obj.hit[i].length; j++) {
      writefln("%s\t%f\t%f", obj.stest, obj.hit[i][j], obj.hot[i][j]);
    }
  }
}
