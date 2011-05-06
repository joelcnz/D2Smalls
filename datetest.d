import std.stdio;
import std.date;
import std.c.time;
import std.string: newline;

void main() {
	time_t bigTime;

	time(&bigTime);
	
	showTime("time(&bigTime);", bigTime);
	// from big number to date and time numbers
	long dt = UTCtoLocalTime(getUTCtime);
	
	showTime("long dt = UTCtoLocalTime(getUTCtime);", dt);
	// from date and time numbers to big number
	Date date;
	with (date)
	{
		day = 25;
		month = 9;
		year = 2010;

		hour = 10;
		minute = 46;
		second = 1;
		ms = 0;

		// madeDay doesn't get a big number
		// I think from the start of the day
		version (none)
			showTime("makeDay makeTime", makeDay(year, month, day) + makeTime(hour, minute, second, ms));
		showTime( "makeTime(hour, minute, second, ms)", makeTime(hour, minute, second, ms) );
	}
}

void showTime(string title, long dt)
{
	writefln("%s"~ newline ~
		"(%s) %s/%s/%s, [%s:%s.%s%s]", title, dt,
		dateFromTime(dt) + 1, monthFromTime(dt) + 1, yearFromTime(dt),
		(hourFromTime(dt) == 0 || hourFromTime(dt) == 12 ? 12 : hourFromTime(dt)), minFromTime(dt), secFromTime(dt),
		hourFromTime(dt) < 12 ? "am" : "pm");
}
