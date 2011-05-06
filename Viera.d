module viera;

/**
	Started at Ria's place on her big tv. 16/07/2010 3:16 (started earlier than just statted)
	3:25pm quit
*/

import std.stdio;
import std.string;
import jec2.all;

void main() {
	Init(split("-mode window"));
	auto remotecontrol = new RemoteControl;
	remotecontrol.run;
}

class RemoteControl {
private:
	TV _tv;
public:
	TV tv() { return _tv; }
	TV tv(ref TV tv0) { return _tv=tv0; }
	this() {
		_tv=new TV("Viera");
	}
	void run() {
		BITMAP* stamp=create_bitmap(SCREEN_W, SCREEN_H);
		do {
			with (tv) {
				int holdingKey;
				if (key[KEY_O]) {
					on = on ? false : true;
					holdingKey=KEY_O;
				}
				foreach (k; KEY_1 .. KEY_9 + 1)
					if (key[k])
						holdingKey=k, channel=k-KEY_1+1;
				while (key[holdingKey]) {}
				update(stamp);
			}
			blit(stamp, screen, 0, 0, 0, 0, SCREEN_W, SCREEN_H);
			rest(10);
		} while (! key[KEY_ESC]);
		destroy_bitmap(stamp);
	}
}

class TV {
private:
	string _tvType;
	bool _on;
	int _channel;
public:
	string tvType() { return _tvType; }
	string tvType(string tvType0) { return _tvType=tvType0; }
	bool on() { return _on; }
	bool on(bool on0) { if (on0) reset; return _on=on0; }
	int channel() { return _channel; }
	int channel(int channel0) { return _channel=channel0; }
	this(string tvType) {
		this.tvType=tvType;
		on=false;
	}
	void reset() {
		channel=1;
	}
	void update(BITMAP* bmp) {
		rectfill(bmp, 100, 50, 200, 120, Colour.green);
		if (on)
			textprintf_ex(bmp, font, 130, 80, Colour.white, 0,
				toStringz(format("%s", channel)));
	}
}
