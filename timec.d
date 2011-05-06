/**
	Got this code (but altered it) from: http://www.gnu.org/s/libc/manual/html_node/Time-Functions-Example.html
*/
import std.stdio;
import std.datetime;
import std.c.time;

version (none)
{
	int tm_sec;  /* seconds (0 - 60) */
	int tm_min;  /* minutes (0 - 59) */
	int tm_hour;  /* hours (0 - 23) */
	int tm_mday;  /* day of month (1 - 31) */
	int tm_mon;  /* month of year (0 - 11) */
	int tm_year;  /* year - 1900 */
	int tm_wday;  /* day of week (Sunday = 0) */
	int tm_yday;  /* day of year (0 - 365) */
	int tm_isdst;  /* is summer time in effect? */
	char *tm_zone;  /* abbreviation of timezone name */
	long tm_gmtoff;  /* offset from UTC in seconds */
}

int
main ()
{
	time_t curtime;
	tm* loctime;

	/* Get the current time. */
	curtime = time(null);

	/* Convert it to local time representation. */
	loctime = localtime(&curtime);

	alias loctime l; // with (loctime) not work
	writefln("%04s/%02s/%s [%s%s:%02s.%02s]",
			l.tm_year + 1900,
			l.tm_mon + 1,
			l.tm_mday,
			l.tm_hour > 11 ? "\'" : "",
			l.tm_hour == 0 || l.tm_hour == 12 ? 12 : l.tm_hour % 12,
			l.tm_min,
			l.tm_sec);
	
	return 0;
}
/*
// Works
	long curtime;
	tm* loctime;
	curtime = time(null);
	loctime = localtime(&curtime);

	writefln("Time: [%02s:%02s%s]",
		tm.hour == 12 || tm.hour == 0 ? 12 : tm.hour % 12,
		tm.minute, tm.hour <=11 ? "am" : "pm");

*/