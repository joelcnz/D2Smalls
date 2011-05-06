/*
nonzerokey.d, by leonardo maffi, V.1.0, Apr 23 2010.

This program was born after reading the section "Scan array of packed structure
for non-zero key" of the "Assembly Language Lab" HTML page by Paul Hsieh:
http://www.azillionmonkeys.com/qed/asmexample.html

The purpose is to benchmarks ways to find a struct (here just named 'P')
with a nonzero field 'key' inside an array. The code works with D1+Tango and
D2+Phobos.

--------------------------

first_nonzero_key1: shows the baseline way, it's simple, easy to write, and
not bug-prone. LDC compiles it exactly as a normal for() loop.
The loop of first_nonzero_key1 contains two tests (compiled with LDC):

.LBB1_1:
    movl    (%edx,%ecx,8), %eax
    testl   %eax, %eax
    jne .LBB1_5
    incl    %ecx
.LBB1_3:
    cmpl    %esi, %ecx
    jb  .LBB1_1

but Pisen Chiang and
Paul Hsieh show how it can be done with only a test:

    xor     eax,eax
    test    ecx,ecx
    je      L2
    sub     esi,8
L1: add     esi,8       ; 1 U
    sub     ecx,1       ; 1   V
    sbb     eax,eax     ; 2 U -
    or      eax,[esi]   ; 3 U
    jz      L1          ; 4   V +1brt
    mov     eax,[esi]
L2:


The struct P is 8 bytes long, so a CPU cache line can contain 8 of them.

--------------------------

first_nonzero_key2: a commonly used trick in a case like this is the
Sentinel Loop Exit Test, as described for example by Bentley.

It requires a mutable array, and to add an item at the end of the array.
But there is a simple way to avoid adding an item past the end of the array.

This code performs only one test in each loop, and it's quite faster than
first_nonzero_key1.

Asm of the loop compiled with LDC:

.LBB2_3:
    cmpl    $0, 8(%esi)
    leal    8(%esi), %esi
    je  .LBB2_3

It's just three instructsions, apparently you can't be faster.

--------------------------

first_nonzero_key3: but modern CPUs are superscalar and have a pipeline,
so it's often more efficient to put more work inside the loop, and when
possible to take care that the multiple operations inside the loops are
not dependant from each other.

This is similar to first_nonzero_key1, but uses a for loop to unroll
the tests. Thanks to a static foreach it can unroll the loop any
number of times. Here I have tried to partially unroll it 2, 4 or 6
times (currently LLVM is not able to perform such partial unwinding).

When NUNROLL is 4 or even 6, the performance gets equal or even better
than first_nonzero_key2. This is the best version, it's safe enough.

Asm of the loop compiled with LDC, NUNROLL=4:

.LBB8_2:
    cmpl    %esi, %edi
    jge .LBB8_10
    movl    (%edx,%edi,8), %eax
    testl   %eax, %eax
    jne .LBB8_12
    movl    8(%edx,%edi,8), %eax
    testl   %eax, %eax
    jne .LBB8_12
    movl    16(%edx,%edi,8), %eax
    testl   %eax, %eax
    jne .LBB8_12
    movl    24(%edx,%edi,8), %eax
    testl   %eax, %eax
    jne .LBB8_12
    addl    $4, %edi
    jmp .LBB8_2


I'd like D to have a higher level way to ask for such partial unrolling.

--------------------------

first_nonzero_key4, first_nonzero_key5,
first_nonzero_key6, first_nonzero_key7:

various attempts to unroll the first_nonzero_key2, with mixed results.
The Version 7 seems fast enough. But all such versions need to modify the
array, so V3 with NUNROLL=4 or 6 is better.

--------------------------

Timings, N=50_000, NLOOPS=80_000, seconds:
  V1: 5.08
  V2: 3.03
  V3: 3.38 (NUNROLL=2)
  V3: 3.01 (NUNROLL=4)
  V3: 2.99 (NUNROLL=6)
  V4: 3.03
  V5: 3.04
  V6: 5.06
  V7: 2.99

Compiled with:
ldc -O5 -release -inline
LDC based on DMD v1.057 and llvm 2.6 (Tue Mar 23 22:38:09 2010)

*/

version (Tango) {
    import tango.stdc.stdio: printf;
    import tango.stdc.stdlib: exit;
} else {
    import std.c.stdio: printf;
    import std.c.stdlib: exit;
}

template Tuple(T...) {
    alias T Tuple;
}

template Range(int stop) {
    static if (stop <= 0)
        alias Tuple!() Range;
    else
        alias Tuple!(Range!(stop-1), stop-1) Range;
}

struct P {
    uint key;
    void* content;
}

uint first_nonzero_key1(P[] pairs) {
    foreach (pair; pairs)
        if (pair.key)
            return pair.key;
    return 0;
}

uint first_nonzero_key2(P[] pairs) {
    if (!pairs.length)
        return 0;
    auto last_key = pairs[$-1].key;
    pairs[$-1].key = 1;
    int i;
    while (!pairs[i].key)
        i++;
    pairs[$-1].key = last_key;
    return pairs[i].key;
}

uint first_nonzero_key3(int NUNROLL)(P[] pairs) {
    if (!pairs.length)
        return 0;
    int i;
    for (i = 0; i < ((cast(int)pairs.length) - NUNROLL + 1); i += NUNROLL) {
        foreach (j; Range!(NUNROLL))
            if (pairs[i + j].key)
                return pairs[i + j].key;
    }

    for (; i < pairs.length; i++)
        if (pairs[i].key != 0)
            return pairs[i].key;

    return 0;
}

uint first_nonzero_key4(P[] pairs) {
    if (!pairs.length)
        return 0;
    auto last_key = pairs[$-1].key;
    pairs[$-1].key = 1;
    int i;
    while (true) {
        if (pairs[i].key)
            break;
        i++;
        if (pairs[i].key)
            break;
        i++;
    }
    pairs[$-1].key = last_key;
    return pairs[i].key;
}

uint first_nonzero_key5(P[] pairs) {
    if (!pairs.length)
        return 0;
    auto last_key = pairs[$-1].key;
    pairs[$-1].key = 1;
    int i;
    while (true) {
        if (pairs[i].key)
            break;
        i++;
        if (pairs[i].key)
            break;
        i++;
        if (pairs[i].key)
            break;
        i++;
        if (pairs[i].key)
            break;
        i++;
    }
    pairs[$-1].key = last_key;
    return pairs[i].key;
}

uint first_nonzero_key6(P[] pairs) {
    if (!pairs.length)
        return 0;
    auto last_key = pairs[$-1].key;
    pairs[$-1].key = 1;
    int i=0, j=1, k;
    while (true) {
        if (pairs[i].key) {
            k = i;
            break;
        }
        i++;
        if (pairs[j].key) {
            k = j;
            break;
        }
        j++;
    }
    pairs[$-1].key = last_key;
    return pairs[k].key;
}

uint first_nonzero_key7(P[] pairs) {
    if (!pairs.length)
        return 0;
    auto last_key = pairs[$-1].key;
    pairs[$-1].key = 1;
    int i;
    while (!pairs[i].key) {
        i++;
        if (pairs[i].key)
            break;
        i++;
    }
    pairs[$-1].key = last_key;
    if (i >= pairs.length)
        return 0;
    else
        return pairs[i].key;
}

unittest {
    P[][] tests = [cast(P[])null,
                   [P()],
                   [P(1)],
                   [P(), P(2)],
                   [P(), P(3), P()],
                   [P(), P(), P(4)],
                   [P(5), P(6), P(7)],
                   [P(8), P(9), P()],
                   [P(), P(), P(), P(10)],
                   [P(), P(), P(), P(11), P()],
                  ];
    uint[] results = [0,0,1,2,3,4,5,8,10,11];

    foreach(i, t; tests)
        if (first_nonzero_key1(t) != results[i]) {
            printf("err first_nonzero_key1: %d\n", i);
            exit(1);
        }

    foreach(i, t; tests)
        if (first_nonzero_key2(t) != results[i]) {
            printf("err first_nonzero_key2: %d\n", i);
            exit(1);
        }

    foreach(i, t; tests)
        if (first_nonzero_key3!(2)(t) != results[i]) {
            printf("err first_nonzero_key3!(2): %d\n", i);
            exit(1);
        }

    foreach(i, t; tests)
        if (first_nonzero_key3!(4)(t) != results[i]) {
            printf("err first_nonzero_key3!(4): %d\n", i);
            exit(1);
        }

    foreach(i, t; tests)
        if (first_nonzero_key3!(6)(t) != results[i]) {
            printf("err first_nonzero_key3!(6): %d\n", i);
            exit(1);
        }

    foreach(i, t; tests)
        if (first_nonzero_key4(t) != results[i]) {
            printf("err first_nonzero_key4: %d\n", i);
            exit(1);
        }

    foreach(i, t; tests)
        if (first_nonzero_key5(t) != results[i]) {
            printf("err first_nonzero_key5: %d\n", i);
            exit(1);
        }

    foreach(i, t; tests)
        if (first_nonzero_key6(t) != results[i]) {
            printf("err first_nonzero_key6: %d\n", i);
            exit(1);
        }

    foreach(i, t; tests)
        if (first_nonzero_key7(t) != results[i]) {
            printf("err first_nonzero_key7: %d\n", i);
            exit(1);
        }

    printf("Unittests done.\n");
}

void main() {
    version (D_Version2) {
        mixin("enum int N = 50_000;");
        mixin("enum int NLOOPS = 80_000;");
    } else {
        mixin("const int N = 50_000;");
        mixin("const int NLOOPS = 80_000;");
    }

    auto pairs = new P[N];
    int idx = (N / 5) * 4;
    pairs[idx].key = 10;

    int tot;
    for (int i; i < NLOOPS; i++)
        tot += first_nonzero_key7(pairs);

    printf("tot: %d\n", tot);
}
