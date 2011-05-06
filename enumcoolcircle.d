// Out of ng d.learn 24 Feb 2011 12:41
//  Error: non-constant expression ["CoolCircle":50]
enum : int[string] {
    Circle = ["CoolCircle":50]
}

// not work (as the version states)
version ( NotWork ) {
	enum shapes : int[string] {
		Circle = ["CoolCircle":50]
	}
 
}
