// from Craig news group d.D 17.12.2010 3:36
import std.stdio;
import std.random;
import std.algorithm;

static bool less(T)(T a, T b) { return a < b; }

bool isOrdered(A, alias L)(A a, int low, int high)
{
 for(int i = low; i < high; i++)
 {
   if(L(a[i+1], a[i])) return false;
 }
 return true;
}

void insertionSort(A, alias L)(A a, int low, int high)
{
 for(int i = low; i <= high; i++)
 {
   int min = i;
   for(int j = i + 1; j <= high; j++)
     if(L(a[j], a[min])) min = j;
   swap(a[i], a[min]);
 }
}

void quickSort(A, alias L)(A a, int p, int r)
{
 if (p >= r) return;
 if(isOrdered!(A, L)(a, p, r)) return;
 if(p + 7 > r) return insertionSort!(A, L)(a, p, r);
 auto x = a[r];
     int j = p - 1;
     for (int i = p; i < r; i++)
     {
           if (L(x, a[i])) continue;
           swap(a[i], a[++j]);
     }
     a[r] = a[j + 1];
     a[j + 1] = x;
     quickSort!(A, L)(a, p, j);
     quickSort!(A, L)(a, j + 2, r);
}

void customSort(T)(T[] a)
{
 quickSort!(T[], less!T)(a, 0, a.length-1);
}

ulong getCycle() { asm { rdtsc; } }

ulong bench1(double[] vals)
{
 ulong startTime = getCycle();
 double[] v;
 v.length = vals.length;
 for(int i = 0; i < 100; i++)
 {
   for(int j = 0; j < v.length; j++) v[j] = vals[j];
   sort(v);
 }
 return getCycle() - startTime;
}

ulong bench2(double[] vals)
{
 ulong startTime = getCycle();
 double[] v;
 v.length = vals.length;
 for(int i = 0; i < 100; i++)
 {
   for(int j = 0; j < v.length; j++) v[j] = vals[j];
   customSort(v);
 }
 return getCycle() - startTime;
}

void main()
{
 Mt19937 gen;
 double[] vals;
 vals.length = 1000;
 for(int i = 0; i < vals.length; i++) vals[i] = uniform(0.0,1000.0);
 sort(vals[]);

 ulong time1, time2;
 for(int i = 0; i < 100; i++)
 {
   time1 += bench1(vals);
   time2 += bench2(vals);
 }
 writeln("Sorting with phobos sort: ", time1/1e5);
 writeln("Sorting with custom quickSort: ", time2/1e5);
 if(time1 > time2)
   writeln(100.0 * (time1-time2) / time1, " percent faster");
 else
   writeln(100.0 * (time2-time1) / time2, " percent slower");
}
