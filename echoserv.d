// 4 Sep 2010 - Got off digitalmars.d.learn goes with echoclient.d
import std.socket;
import std.array;

void main()
{
    Socket listener = new TcpSocket;
    assert(listener.isAlive);
    listener.bind(new InternetAddress(12321));
    listener.listen(10);

    Socket currSock;
    uint bytesRead;
    ubyte buff[1];

    while(1)
    {
        currSock = listener.accept();
        while ((bytesRead = currSock.receive(buff)) > 0)
        {
            currSock.send(buff);
        }
        currSock.close();
        buff.clear();
    }
}
