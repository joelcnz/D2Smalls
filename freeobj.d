//# just so I know you can do it (the Point part)
/**
	Author: Joel Ezra Christensen
	Date: 26 August 2010
	Intent: Prototype for Balliters, may contain traces of useless code
*/
module freeobject;

// includes part for output on the terminal, also an Allegro wrappper
import std.stdio: writeln, writefln;
import std.string: split, format;
import std.math: abs;
import jec2.all;

//Some of the FreeObject classes use this mixin
// _isAlive maybe redundant
// Set the name graphics and position
// orso speed
const FREE_OBJECT_CONSTRUCTOR = "
	this(string name, string gfx, Point position) {
		m_alive = true;
		m_name=name;
		m_sprite = new Bmp(gfx);
		assert(m_sprite !is null);
		m_position = position;
		m_direction = Point(1,1);
	}";

unittest {
	Init(split("-mode window"));
	auto thingshandle = new FreeObjectHandle;
	with (thingshandle) {
		writeln("Forward:");
		// Bouncer bounces around the screen, you can lay minds and wipe them out though
		add(new Bouncer("Botty", "redblot.bmp", Point(40, 10)));
		print;
		writeln("Forward:");
		// Controled sprite, up down left right and lay mines
		add(new Shifter("Hummer", "redblot.bmp", Point(100, 80)));
		add(new Bouncer("Bottyernator", "redblot.bmp", Point(10, 80)));
		print;
		writeln("Reverse:");
		printReverse;
	}
}

/**
	Entry point
	May add things to the command line when running the program, like '-mode full' for full screen
*/
void main(string[] args) {
	args~=split("-mode window")~args;
	Init(args); // Allegro wrapper JEC2 initualize(sp)

	// thingshandle - to handle the main objects like adding them and removing them
	auto thingsHandle = new FreeObjectHandle;
	// Add some free objects
	with (thingsHandle) {
		// Bouncer bounces around the screen
		add(new Bouncer("Botty", "redblot.bmp", Point(40, 10)));
		add(new Bouncer("Bottyernator", "redblot.bmp", Point(10, 80)));
		// Shifter is the character the player controls
		add(new Shifter("Hummer", "redblot.bmp", Point(100, 80)));
	}

	BITMAP* stamp = create_bitmap(SCREEN_W, SCREEN_H);
	do {
		acquire_bitmap(stamp);
		clear_bitmap(stamp);

		thingsHandle.update;
		thingsHandle.draw(stamp);
		
		acquire_screen();
		blit(stamp, screen, 0,0, 0,0, stamp.w,stamp.h);
		release_bitmap(stamp);
		release_screen();
	} while (! key[KEY_ESC]);
}

class FreeObjectHandle {
	FreeObject head, tail;

	void prepend(FreeObject thing) {
		if (head is null)
			head = tail = thing;
		else {
			FreeObject current = head;
			if (current.next !is null)
				current.next.prev = thing;
			thing.next = current;
			head = thing;
		}
	}
	size_t getElementCount() {
		size_t count=0;
		FreeObject current=head;
		while (current !is null) {
			++count;
			current = current.next;
		}
		return count;
	}	
	void add(FreeObject thing) {
		if (head is null)
			head = tail = thing;
		else {
			tail.next = thing;
			thing.prev = tail;
			tail = thing;
		}
	}
	void removeFreeObject(T)(T current) {
		if (current.prev !is null)
			current.prev.next = current.next; // set the previous next to current next
		else
			head= current.next;
		if (current.next !is null)
			current.next.prev = current.prev; // set the current next to the current previous
		else
			tail=current.prev;
	}
	void update() {
		FreeObject current = head;
		while (current !is null) {
			current.update(this);
			current = current.next;
		}
	}
	void draw(BITMAP* bmp) {
		FreeObject current = head;
		while (current !is null) {
			current.draw(bmp);
			current = current.next;
		}
	}
	void print() {
		FreeObject current = head;
		while (current !is null) {
			current.print;
			current = current.next;
		}
	}
	void printReverse() {
		FreeObject current = tail;
		while (current !is null) {
			current.print;
			current = current.prev;
		}
	}
}

abstract class FreeObject {
	FreeObject prev, next;
protected:
	bool m_alive; //# can't remember the commonly used name for this variable
	string m_name;
	Point m_position;
	Point m_direction;
	Bmp m_sprite;

public:
	bool alive() { return m_alive;	}
	bool alive(bool alive0) { return m_alive = alive0;	}
	void update(FreeObjectHandle);
	bool boundingBoxOverLaps(FreeObject);
	void draw(BITMAP*);
	void print();
}

class Bouncer: FreeObject {
	mixin(FREE_OBJECT_CONSTRUCTOR);
	override void print() {
		writeln(m_name);
	}
	override void update(FreeObjectHandle foh) {
		debug {}
		else
			m_position += m_direction;
		if (m_position.x > SCREEN_W - m_sprite.width ||
			m_position.x < 0)
			m_direction.x *= -1;
		if (m_position.y > SCREEN_H - m_sprite.height ||
			m_position.y < 0)
			m_direction.y *= -1;
	}
	override bool boundingBoxOverLaps(FreeObject other) {
		if (other !is this && abs(m_position.x - other.m_position.x) < 8 &&
			abs(m_position.y - other.m_position.y) < 8)
			return true;
		return false;
	}
	override void draw(BITMAP* bmp) {
		jdraw_sprite(bmp, m_sprite, Point(m_position.x, m_position.y)); //# just so I know you can do it (the Point part)
	}
	void jdraw_sprite(BITMAP* bmp, Bmp sprite, Point position) {
		draw_sprite(bmp, sprite(), position.x, position.y);
	}
}

class Shifter: FreeObject {
	mixin(FREE_OBJECT_CONSTRUCTOR);
	struct Key {
		int _key;
		bool _keyPressed;
		bool keyP() {
			if (_keyPressed == false) {
				_keyPressed = true;
				return key[_key] != 0;
			}
			return false;
		}
		void checkAndMayClear() {
			if (! key[_key])
				_keyPressed = false;
		}
	}
	Key keySpace=Key(KEY_SPACE);
	override void print() {
		writeln(m_name);
	}
	override void update(FreeObjectHandle foh) {
		if (key[KEY_UP])
			m_position.y-=m_direction.y;
		if (key[KEY_RIGHT])
			m_position.x+=m_direction.x;
		if (key[KEY_DOWN])
			m_position.y+=m_direction.y;
		if (key[KEY_LEFT])
			m_position.x-=m_direction.x;
		//if (key[KEY_SPACE])
		if (keySpace.keyP)
			//foh.prepend(new Mine("mine", m_position + Point(10,10)));
			foh.add(new Mine("mine", m_position + Point(10,10)));
		keySpace.checkAndMayClear;
		if (key[KEY_R]) {
			writeln("[START]");
			foh.print;
			while(key[KEY_R]) {}
		}
	}
	override bool boundingBoxOverLaps(FreeObject other) {
		if (other !is this && abs(m_position.x - other.m_position.x) < 20 &&
			abs(m_position.y - other.m_position.y) < 20)
			return true;
		return false;
	}
	override void draw(BITMAP* bmp) {
		void jdraw_sprite(BITMAP* bmp, Bmp sprite, Point position) {
			draw_sprite(bmp, sprite(), position.x, position.y);
		}
		jdraw_sprite(bmp, m_sprite, m_position);
	}
}

class Mine: FreeObject {
	private uint m_countDown;
	this(string name, Point position) {
		m_name = name;
		m_position = position;
		m_countDown = 500;
	}
	override void update(FreeObjectHandle foh) {
		m_countDown--;
		if (m_countDown == 0) {
			alive = false;
			foh.removeFreeObject(this);
		}
		FreeObject current=foh.head;
		while (current !is null) {
			if (current !is this && current.m_name.length >= "Botty".length && current.m_name[0.."Botty".length]=="Botty" &&
				current.boundingBoxOverLaps(this) == true)
				foh.removeFreeObject(current);
			current = current.next;
		}
	}
	override bool boundingBoxOverLaps(FreeObject other) {
		if (other !is this && abs(m_position.x - other.m_position.x) < 8 &&
			abs(m_position.y - other.m_position.y) < 8)
			return true;
		return false;
	}
	override void draw(BITMAP* bmp) {
		circlefill(bmp, m_position.x,m_position.y, 5, Colour.red);
	}
	override void print() {
		writeln("Mine");
	}
}

/**
	Or maybe I should call it Vector2 like in XNA (but what's the point ;-)
*/
struct Point {
	// The two variables for position or direction
	int x, y;
	// An overload for doing like a += b; (same as a.x += b.x; a.y += b.y;)
	void opOpAssign(string op)(Point p)
		if (op == "+") {
			x += p.x;
			y += p.y;
		}
	void opAssign(Point p) {
		x=p.x;
		y=p.y;
	}
	Point opBinary(string op)(Point p) { // eg. Point a,b,c; ... c = a + b
		Point newValue=this;
		if (op=="+")
			newValue=Point(x + p.x, y + p.y);
		if (op=="*")
			newValue=Point(x * p.x, y * p.y);
		if (op=="/") {
			if (x==0 || y==0 || p.x==0 || p.y==0)
				newValue=this;
			else
				newValue=Point(x / p.x, y / p.y);
		}
		return newValue;
	}
	unittest {
		Point a, b, c;
		string print(Point p) {
			return format("(%s, %s)",p.x, p.y);
		}
		a=Point(0,2);
		b = Point(10,20);
		writeln("a="~print(a)~" b="~print(b));
		
		writeln("a + b = "~print(a + b));
		a=Point(6,20);
		b=Point(2,10);
		writeln(print(a)~" "~print(b));
		writeln("b/a="~print(a/b));
	}
}
