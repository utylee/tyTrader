import socket
import asyncio

def reader():
    buf = r.recv(1)
    print('successs')
    loop.stop()

r, w = socket.socketpair()

loop = asyncio.get_event_loop()
loop.add_reader(r, reader)
loop.call_soon(w.send, b'x')

loop.run_forever()


