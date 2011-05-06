import std.datetime, std.stdio, std.random;

version = ManualInline;

// immutable N = 20000;
immutable N = 2_000;
immutable Size = 10;

alias int value_type;
alias long result_type;
alias value_type[] vector_type;

result_type scalar_product(in vector_type x, in vector_type y)
in
{
    assert(x.length == y.length);
}
body
{
    result_type result = 0;

    foreach(i; 0 .. x.length)
        result += x[i] * y[i];

    return result;
}

void main()
{   
    auto startTime = Clock.currTime();

    // 1. allocate vectors
    vector_type[] vectors = new vector_type[N];
    foreach(ref vec; vectors)
        vec = new value_type[Size];

    auto time = Clock.currTime() - startTime;
    writefln("allocation: %s ", time);
    startTime = Clock.currTime();

    // 2. randomize vectors
    foreach(ref vec; vectors)
        foreach(ref e; vec)
            e = uniform(-1000, 1000);

    time = Clock.currTime() - startTime;
    writefln("random: %s ", time);
    startTime = Clock.currTime();

    // 3. compute all pairwise scalar products
    result_type avg = 0;

    foreach(vecA; vectors)
        foreach(vecB; vectors)
        {
            version(ManualInline)
            {
                result_type result = 0;

                foreach(i; 0 .. vecA.length)
                    result += vecA[i] * vecB[i];

                avg += result;
            }
            else
            {
                avg += scalar_product(vecA, vecB);
            }
        }

    avg = avg / (N * N);

    time = Clock.currTime() - startTime;
    writefln("scalar products: %s ", time);
    writefln("result: %s", avg);
}
