import std.stdio;
import std.string;

void main() {
	
}

struct Pt {
	int x, y;
	typeof(this) opBinary(string op)(Pt p) {
		if (op=="+")
			return Pt(x+p.x, y+p.y);
	}
	void opAssign(Pt p) {
		x=p.x;
		y=p.y;
	}
	unittest {
		string print(Pt p) {
			return format("(%s, %s)", p.x, p.y);
		}
		writeln("Pt start:");
		Pt a=Pt(3,7);
		Pt b=Pt(7,3);
		Pt c;
		c = a+b;
		writeln(print(a)~" + "~print(b)~" c=a+b - ", print(c));
		c=a+b;
		writeln("Pt end:\r\n");
	}
}

struct Point {
	int x, y;
	void opOpAssign(string op)(Point p) {
		if (op=="+")
			writeln("opOpAssign"), x+=p.x, y+=p.y;
	}
	void opAssign(Point p) {
		writeln("opAssign");
		x=p.x;
		y=p.y;
	}
	Point opBinary(string op)(Point p) {
		if (op=="+")
			return Point(x+p.x, y+p.y);
		else if (op=="*")
			return Point(x*p.x, y*p.y);
//		return p;
	}	
	void show(Point p) {
		writeln(x, ' ', y);
	}
	unittest {
		writeln("Start of Point unittest:");
		string print(Point p) {
			return format("(%s, %s)", p.x, p.y);
		}
		Point x,y,z;
		
		x=Point(5, 6);
		y=Point(2, 2);
		z=x*y;
		writeln(print(x)~" * "~print(y)~" = "~print(z));
		
		Point a, b, c;
		a+=Point(30,37);
		writeln("a=", a.x, " b=", a.y);
		writeln("a+x=", (a+Point(70,63)).x, ",", (a+Point(70,63)).y);
		b = Point(10,10);
		write("b=", ' ');
		b.show(b);
		c = a + b;
		writeln("c = a + b - (", c.x, ' ', c.y, ")");
		writeln("End of Point unittest.\n");
	}
}

struct Assign {
	int x,y;
	unittest {
		writeln("Start of Assign unittest:");
		string print(Assign a) {
			return format("(%s, %s)", a.x, a.y);
		}
		Assign a = Assign(2,3);
		writeln("a=", print(a));
		writeln("Was: ", print(a), " a=Assign(30, 37)");
		a=Assign(30, 37);
		writeln("Now: ", print(a), " with no overload");
		writeln("End of Assign unittest.");
	}
}
