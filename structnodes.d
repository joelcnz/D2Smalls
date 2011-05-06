///NodePtr list program
module nodeptr;

import std.stdio;

int main( string[] args) {
    writefln("Hello DMD2 world! :-)\n%s", typeid(typeof(args)));
    List list;
    with( list ) {
   	 add( 1 ).
   		 add( 2 ).
   		 add( 4 ).
   		 add( 79 );
   	 add( [1, 2, 4, 79, 28] );
   	 display;
   	 write( "\nSum total: ", getSumTotal );
    }
    
    return 0;
}

struct Node {
    int value;
    Node* next;

    this( int value ) {
   	 this.value = value;
    }
}

struct List {
    Node* head;

/// add with array - O(N), should be O(N) first push, then O(1) I think the other pushes
    void add( int[] newValues ) {
   	 foreach( int value; newValues )
   		 add( value );
    }
    
    typeof(this) add( int newValue ) {
   	 auto node = new Node( newValue );
   	 if ( head is null ) {
   		 head = node;
   		 return this;
   	 }
   	 Node*
   		 current = head,
   		 last;
   	 while( current !is null ) {
   		 last = current;
   		 current = current.next;
   	 }
   	 last.next = node;

   	 return this;
    }
    
    void display() {
   	 Node* current = head;
   	 while( current !is null ) {
   		 writef( "%s ", current.value );
   		 current = current.next;
   	 }
    }
    
    int getSumTotal() {
   	 int total = 0;
   	 Node* current = head;
   	 while( current !is null ) {
   		 total += current.value;
   		 current = current.next;
   	 }
   	 
   	 return total;
    }
}
