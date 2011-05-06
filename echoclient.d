// 4 Sep 2010 - Got off digitalmars.d.learn goes with echoserv.d
import std.socket;
import std.stdio;
import std.string;

void main()
{
    Socket sock = new TcpSocket(new InternetAddress("localhost", 12321));

    string[4] messages = ["Hello world.", "Hello\nworld.", "\tHello world.",
        "Goodby cruel world..."];

    ubyte buff[1];
    int bytesRead;

    foreach (msg; messages)
    {
        sock.send(msg);
        for (int i = 0; i < msg.length; i++)
        {
            bytesRead = sock.receive(buff);
            write(cast(char)buff[0]);
        }
        /*
        string temp = cast(string)buff;
        writeln(temp, "\n");
        */
        write("\n");
    }

    sock.close();
}
