
//Written in the D programming language

//      This program is free software; you can redistribute it and/or modify
//      it under the terms of the GNU General Public License as published by
//      the Free Software Foundation; either version 3 of the License, or
//      (at your option) any later version.
//
//      This program is distributed in the hope that it will be useful,
//      but WITHOUT ANY WARRANTY; without even the implied warranty of
//      MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//      GNU General Public License for more details.
//
//      You should have received a copy of the GNU General Public License
//      along with this program; if not, write to the Free Software
//      Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
//      MA 02110-1301, USA.


module libcalc;

debug import std.stdio : writeln;
import std.math;
import std.conv;
import std.regexp : sub, RegExp, search;
import std.string : whitespace, replace, replaceSlice, removechars, split, indexOf;

private static string delegate(string)[] commands;
private static string[] rules;

const string FLOAT = r"[+-]?[0-9]*\.?[0-9]+";
const string INT = r"[^+-\.][+-]?[0-9]+";
const string STRING = ".*";

/**
 * Add standard math rules to calc.
 * Currently:
 *  * Basic operators +, -, *, /, Brackets
 *  * Power: ^
 *  * Root: N root X, e.g. : 2 root (16) = 4
 *  * sinus, cosinus and tangens
 */

static this () {
	//Where is possible, use to instead of parse, Should be faster and saver.
	addRule (0, "PI", delegate string (string match) { return text (PI); });

	addRule (1, "[STRING", delegate string (string match) {
		return match.replace ("[", "(").replace("]", ")");
	}); addRule (2, "{STRING", delegate string (string match) {
		return match.replace ("{", "(").replace("}", ")");
	}); addRule (3, "(STRING", delegate string (string match) {
		//Cout open and close brackets
		uint bracket_count = 1; //The first bracket
		foreach (i, c; match[1..$]) {
			if (c == '(') bracket_count++;
			else if (c == ')') bracket_count--;
			if (bracket_count == 0) {//all brackets closed, break
				//Calculate all subtasks, seperated by ','
				auto tasks = match[1..i+1].split (",");
				string result;
				foreach (task; tasks) result ~= text(calc(task)) ~ ',';
				return result[0..$-1] ~ match[i+2..$]; //Remove last komma
			}
		}
		//Add here (pos == 4) functions
		throw new Exception ("Incorrect brackets!");
	}); addRule (4, "FLOAT%", delegate string (string match) {
		return text (to!real(match[0..$-1]) / 100);
	}); addRule (5, "FLOAT^FLOAT", delegate string (string match) {
		return text (parse!double(match) ^^ to!double(match[1..$]));
	}); addRule (6, "FLOATrootFLOAT", delegate string (string match) {
		auto root = 1 / parse!double(match);
		auto number = to!double(match[4..$]);
		return text (number ^^ root);
	}); addRule (7, "FLOATmodFLOAT", delegate string (string match) {
		return text (parse!real(match) % to!real(match[3..$]));
	}); addRule (8, "sinFLOAT", delegate string (string match) {
		return text (sin (to!real (match[3..$])));
	}); addRule (9, "cosFLOAT", delegate string (string match) {
		return text (cos (to!real (match[3..$])));
	}); addRule (10, "tanFLOAT", delegate string (string match) {
		return text (tan (to!real (match[3..$])));
	}); addRule (11, "logFLOAT", delegate string (string match) {
		return text (log (to!real (match[3..$])));
	}); addRule (12, "FLOAT*FLOAT", delegate string (string match) {
		return text (parse!real(match) * to!real(match[1..$]));
	}); addRule (13, "FLOAT/FLOAT", delegate string (string match) {
		return text (parse!real(match) / to!real(match[1..$]));
	}); addRule (14, "FLOAT+FLOAT", delegate string (string match) {
		return text (parse!real(match) + to!real(match[1..$]));
	}); addRule (15, "FLOAT-FLOAT", delegate string (string match) {
		return text (parse!real(match) - to!real(match[1..$]));
	});
}

/**
 * Add a function to the queue,
 * The strings have following syntax:
 * 'FLOAT' will be replaced with a float number
 * 'INT' will be replaced with a integer (experimental)
 * 'STRING' will be replaced with a string with length >= 1
 * all other characters will be so as is
 */
static void addRule (uint pos, string regex, string delegate(string) func) {
	//Replace all chars exept i and f with \$
	regex = regex.sub ("[^a-zA-Z]", "\\$&", "g");
	//Replace i and f with the numbers - Expression
	regex = regex.replace ("INT", INT);
	regex = regex.replace ("FLOAT", FLOAT);
	regex = regex.replace ("STRING", STRING);

	rules = rules[0..pos] ~ regex ~ rules[pos..$];
	commands = commands[0..pos] ~ func ~ commands[pos..$];
}
/**
 * This function adds a function definition at runtime
 * The different variables must be named starting from a
 */

//I *LOVE* this code ;)
void addFunc (string def, string func) {
	//Build Regex
	def = def.removechars (whitespace);
	func = func.removechars (whitespace);
	auto regex = def.search (r"\(.*\)").pre
		~ def.search (r"\(.*\)")[0].sub ("[a-z]", "FLOAT", "g").sub("[()]", "", "g");
	debug writeln ("regex to add: ", regex);

	addRule (4, regex, delegate string (string match) {
		//Get Variables
		int i = 0;
		string task = func;
		foreach (found; RegExp (FLOAT).search(match)) {
			task = task.replace ([cast(char)('a' + i)], found[0]);
			debug writeln ("new task = ", task);
			i += 1;
		}
		//Calculate
		debug writeln ("calculate function ", task);
		return to!string (calc (task));
	});
}
///The calc main function
///Returns the result of the string "rechnung"
real calc (string rechnung) {
	//Remove all whitespaces
	rechnung = rechnung.removechars (whitespace);
	//calculate all possible operations
	foreach (i, rule; rules) {
		debug writeln ("regex: ", rule);
		//Search for
		RegExp found = std.regexp.search (rechnung, rule);
		while (found) {
			debug writeln ("found! ", found[0]);
			auto  result = commands[i] (found[0]);
			if (indexOf ("0123456789", result[0]) != -1) result = '+' ~ result;
			rechnung = rechnung.replaceSlice (
				rechnung[found.pre.length..found[0].length + found.pre.length],
				result);
			debug writeln ("new calculation: ", rechnung);
			found = std.regexp.search (rechnung, rule);
		}
	}
	//Return result or throw a conv - Exception
	real result;
	try result = to!real (rechnung);
	catch (ConvError e) throw new Exception ("calc: cannot calculate task " ~rechnung);
	return result;
}
