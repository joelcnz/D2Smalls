void main() {
    int[] a1 = [1, 2];
    assert(!!a1);

    int[] a2;
    assert(!a2);

    a1.length = 0;
    assert(!!a1);
}
