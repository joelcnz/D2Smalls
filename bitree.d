import std.stdio;

void main() {
	Tree tree;
	writeln( "Inserting" );
	tree.insert( [9,2,8,3,7,6,4,0,0,1]);
	writeln( "printing" );
	tree.print;
}

struct Tree {
	Node top;
	class Node {
		Node
			left = null,
			right = null;
		bool leaf = false; // not sure on
		alias int data;
		data _num;
		int num() { return _num; }
		this( int num0 ) {
			_num = num0;
		}
	}
	
	typeof(this) insert( int[] nums ) {
		foreach( num; nums ) {
			insert( num );
		}

		return this;
	}
	
	typeof(this) insert( int num ) {
		//Adding
		writeln( num );
		if ( top is null ) {
			top = new Node( num );
			return this;
		}
		auto node = top;
		while ( node !is null ) {
			if ( node.left !is null && node.right !is null ) {
				if ( node.left.num > node.right.num )
					node = node.left, writeln( "bigger" );
				else
					node = node.right, writeln( "smaller" );
			} else if ( node.left !is null )
				node = node.left, writeln( "left !is null" );
			else if ( node.right !is null )
				node = node.right, writeln( "right !is null" );
			else 
				node = null, writeln( "null" );
				
		}
		node = new Node( num );
		
		return this;
	}
	
	typeof(this) print() {
		Node seek( Node node ) {
			writeln( node.num );

			if ( node.left !is null )
				seek( node.left );
			else if ( node.right !is null )
				seek( node.right );

			return null;
		}

		seek(top);
		/*
		auto node = top;
		while( node !is null ) {
			
			
		}
		*/
		
		return this;
	}
}
