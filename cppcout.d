import std.stdio;
import std.conv;

//string endl = "\r\n";
string endl() {
	stdin.flush;
	return "\r\n";
}

void main() {
	auto cout=new CPPCout;
	auto cin=new CPPCin;
	int n=37;
	cout << "house" << " cat " << n << " " >> "mouse" << endl;
	struct Person {
		const JOEL_AGE=31;
		string name;
		int age;
		void enterName() {
			cout << "Enter your name: ";
			cin >> name;
		}
		void enterAge() {
			cout << "Enter your age: ";
			cin >> age;
		}
		void outCome() {
			cout << "Ok, so your name is " << name << endl;
			cout << "And you are " << age << " years old" << endl;
		}
		void eval() {
			if (age==JOEL_AGE)
				cout << "You're Joel aren't you, who else is " << age << " years old?" << endl;
			else
				cout << "Who are you?! Only Joel uses his programs!" << endl;
		}
	}
	Person prsn;
	prsn.enterName;
	prsn.enterAge;
	prsn.outCome;
	prsn.eval;
}

class CPPCout {
	typeof(this) opBinary(string op,T)(auto ref T value) {
		switch (op) {
			case "<<":
				write(value);
			break;
			case ">>":
				write("*", value, "*");
			break;
			default:
			break;
		}
		return this;
	}
}

class CPPCin {
	typeof(this) opBinary(string op, T)(auto ref T value) {
		if (op==">>") {
			string str;
			stdin.readln(str);
			str=str[0 .. $-1];
			value=to!T(str);
		}
		return this;
	}
}
