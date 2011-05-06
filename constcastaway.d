// dmd constcastaway -c
//not work

class M {
  bool set;
  real val;

  real D() const {
    if(!set) {
      M m = cast(M)this;
      m.val = this.some_fn();
      m.set = true;
    }
    return this.val;
  }
  
  real some_fn() {
	  return 1979;
  }
}
