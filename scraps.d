//push objects, kind of. Fail, actually!
		foreach (s; sps)
			if (s !is this) {
				void clean() {
					rectfill(screen, cast(int)s.xpos, cast(int)s.ypos, cast(int)(s.xpos + s.width), cast(int)(s.ypos + s.height), 0);
				}
				// side ways
				if (_y + s.height >= s.ypos && _y <= s.ypos + height) {
					// right
					if (_x + width >= s.xpos && _x <= s.xpos + width / 2)
						clean, s.xpos = s.xpos + 1;
					// left
					if (_x >= s.xpos + s.width / 2 && _x <= s.xpos + s.width && _y + s.height >= s.ypos && _y <= s.ypos + height)
						clean, s.xpos = s.xpos - 1;
				}
				if (_x + width >= s.xpos && _x <= s.xpos + s.width) {
					// down
					if (_y + height / 2 >= s.ypos && _y <= s.ypos + s.height / 2)
						clean, s.ypos = s.ypos + 1;
				}
			}


// go through the alphabet
void loadAnimation(Done done) {
	char c = 'A';
	do {
		textprintf_ex(screen, font, SCREEN_W / 2, SCREEN_H / 2, Colour.amber, 0, toStringz(format(c)));
		if (c == 'Z')
			c = 'A';
		else
			c++;
		rest(10);
		if (key[KEY_ESC])
			done(true);
	} while (! done());
}
