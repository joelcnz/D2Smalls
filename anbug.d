// I don't know the problem here. - Joel
import std.math, std.stdio;

void main() {
    auto a = [ 4, 4, 2, 3, 2 ];
    float avgdist = 0;
    uint count;

    foreach (i, e1; a) {
        foreach (j, e2; a) {
            if (i == j) continue;
            if (e1 != e2) continue;
            ++count;
            avgdist += abs(i - j);
        }
    }

    writeln(count, " ", avgdist / count);
}
