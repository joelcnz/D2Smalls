import std.stdio;
import std.string;
import File=std.file;
import std.array;

Out[] map (In, Out) (In[] source, Out delegate (In) f) {
    // (0)
    Out[] target;
    foreach (element; source)
        target ~= f(element);
    return target;
}

struct StoreStack (T) {
    T[] items;
    string logFileName;
    this (string logFileName, T[] items=[]) {
        this.items = items;
        this.logFileName = logFileName;
        // create/reset log file
        File.write(logFileName, "");
    }
    string toString () {
        static form = "StoreStack(\"%s\", %s)";
        return format(form, this.logFileName, this.items);
    }

    void put (T item) {
        this.items ~= item;
        string message = format("put item: %s\n", item);
        File.append(logFileName, message);
    }
    T take () {
        T item = this.items[$-1];
        this.items = this.items[0..$-1];
        string message = format("took item: %s\n", item);
        File.append(logFileName, message);
        return item;
    }
}

unittest {
    // map
    string hex (uint i) { return format("0x%03X", i); }
    uint[] decs = [1, 3, 9, 27, 81, 243, 729];
    auto hexes = map!(uint,string)(decs, &hex);
    // auto hexes = map(decs, &hex);  // (1)
    writefln ("decs: %s\n-->\nhexes: %s", decs, hexes);
    writeln();

    // StoreStack
    auto store = StoreStack!(int)("test_log");
    // auto store = StoreStack!int("test_log");  // (2)
    store.put(3); store.put(2); store.put(3);
    auto i = store.take();
    writefln("store: %s", store);
    writefln("log:\n%s", File.readText("test_log"));
}
void main() {} 
