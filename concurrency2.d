//Not work, (copied and pasted it too!) :-\
import std.algorithm, std.concurrency, std.stdio;
 
 void main() {
  enum bufferSize = 1024 * 100;
  auto tid = spawn(&fileWriter);
  // Read loop
  foreach (immutable(ubyte)[] buffer;
           stdin.byChunk(bufferSize)) {
    send(tid, buffer);
  }
 }
 void fileWriter() {
  // Write loop
  for (;;) {
    auto buffer = receiveOnly!(immutable(ubyte)[])();
    tgt.write(buffer);
  }
 }
 