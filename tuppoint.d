import std.stdio;

void printPosition(float x, float y, float z) {
	writeln( x, " ", y, " ", z );
}

struct Point {
	float x; float y; float z;

}

void main() {
	Point m_currentPos = {1,2,3};
	
	printPosition(m_currentPos.tupleof); // A
	
	//A is equivalent to typing out: // B
	printPosition( m_currentPos.x, m_currentPos.y, m_currentPos.z );
	
	writeln( m_currentPos.tupleof.stringof );
	writeln( typeid( m_currentPos.tupleof ) );
}
