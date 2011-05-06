module nbottles ;
import std.string ;
import std.stdio ;
 
alias Exception NoMoreBottlesLeft  ;
 
enum { // role
  None    = 0x0, // normal for OP and Term 
  Taker   = 0x1, // for OP that minus one bottlesLeft
  Viewer  = 0x2, // for Term display bottlesLeft
  NewLine = 0x4, // for Term that sending a newline to IO
}
class XP {
  static string[] ones = ["","one","two","three","four",
                          "five","six","seven","eight","nine"] ;
  static string[] tens = ["", "ten", "twenty","thirty","fourty",
                          "fifty","sixty","seventy","eighty","ninty"] ;
  static string[] teens = ["","eleven","twelve","thirteen","fourteen",
                           "fifteen","sixteen","seventeen","eighteen","nineteen"] ;
  static private int bottlesLeft = 99 ;
  static bool opCall() {
    if (bottlesLeft == 0)
      throw new NoMoreBottlesLeft("") ;
    return true ;
  }
  static string Cap(string s) {
    return toupper(s[0..1]) ~ s[1..$] ;
  }
  static string num2word(int i) {
    if (i == 0)
      return "No more" ;
  //return std.string.toString(i) ;
    string[2] digits ;    
    int numTen = i / 10 ;   
    int numOne = i % 10 ;
    if(i == 10) 
      digits[1] = tens[1] ;      
    else if(numTen == 0)
      digits[1] = ones[numOne] ;
    else if(numTen == 1)
      digits[1] = teens[numOne] ;
    else {
      digits[0] = tens[numTen] ;
      digits[1] = ones[numOne] ;
    }     
    return Cap(strip(join(digits," "))) ;
  }
  static string getBottles() {
    string num = num2word(bottlesLeft) ;
    string pural = (bottlesLeft != 1) ? "s" : "";
    return num ~ " bottle" ~ pural ;
  }
  string words ;
  int role ;
  this (string w, int r) { words = w, role = r ; }
  string getWord() {
    string postfix = " ";
    string word ;
    if (words is null)
      return "" ;
    else
      word = words ;
    if (role & Viewer)
      word = getBottles ;
    if (role & NewLine)
      postfix = "\n" ;
    return word ~ postfix ;
  }
}
alias XP A_drunker_sings_a_song ;
 
class Term : XP { 
  this (string w = null, int r = None) { super(w, r) ; }
}
class OP : XP {
  this (string w = null, int r = None) { super(w, r) ; }
  OP opDiv_r(Term t) {
    if(role & Taker)
      A_drunker_sings_a_song.bottlesLeft-- ;
    writef(t.getWord) ;
    writef(getWord) ;
    return this ;         
  }
  Term opDiv(Term t) {
    writef(t.getWord) ;
    return new Term ;
  }
}
 
void main() {
  Term N_bottles = new Term("", Viewer) ;
  OP of = new OP("of") ;
  Term beer = new Term("beer") ;
  OP on = new OP("on") ;
  Term the_wall = new Term("the wall", NewLine) ;
  Term beer_ = new Term("beer", NewLine) ;
  Term Take = new Term("Take") ;
  OP one = new OP("one", Taker) ;
  Term down = new Term("down,") ;
  Term pass = new Term("pass") ;
  OP it = new OP("it") ;
  Term around = new Term("around", NewLine) ;
  Term the_wall_ = new Term("the wall\n", NewLine) ;
 
  try{
    for(; A_drunker_sings_a_song();
 
      N_bottles/of/beer/on/the_wall,
      N_bottles/of/beer_ ,
      Take/one/down, pass/it/around,
      N_bottles/of/beer/on/the_wall_
 
    ) {}
  } catch (NoMoreBottlesLeft e) {
    writefln("Go buy more beer!") ;
  }
 
}
// first post at 
