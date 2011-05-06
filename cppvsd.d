import std.stdio;
import std.string;

void main(){

  size_t[string] dictionary;
  foreach(line; stdin.byLine()){
    foreach(word; splitter(strip(line))){
      if(word in dictionary) continue;
      dictionary[word.idup] = 1;
    }
  }
  writeln("Words: ", dictionary.length);
}
