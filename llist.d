// 8 August 2010
// Bombed out! :-/
import std.stdio;

void main() {
	//alias Thing!Text t;
	//t
//	Thing!Text t;
	
	SomeObj sobj={3, 7};
	SomeObj sobj2;
	sobj.n=sobj2;
	
//	while (
}

struct Manage {
	SomeObj* so;
}

struct SomeObj {
	int x,y;
	SomeObj* p, n;
}

class LList {
	class Node {
		int number;
		Node next;
		this(int number) {
			this.number=number;
		}
		void print() {
			writeln(number);
		}
	}
}

/*
class Text {
	char c;
	void print() {
		write(c);
	}
}

class Thing(T) {
	class Node(T) {
		Node next;
		this(T node) {
			
		}
	}
	T head;
	void add(T thing) {
		if (head is null)
			head=new Node(thing);
		else {
			Node current=head, last;
			while (current.next !is null) {
				last=current;
				current=current.next;
			}
			current=new Node(thing);
			last.next=current;
		}
	}
	void print() {
		Node current=head;
		while(current !is null) {
			//current
			current=current.next;
		}
	}
}
*/
