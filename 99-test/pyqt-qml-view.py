import sys
import asyncio
import time

from quamash import QEventLoop

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine

app = QGuiApplication(sys.argv)
loop = QEventLoop(app)
engine = QQmlApplicationEngine("main.qml")
window = engine.rootObjects()[0]
#window = engine.rootObjects()
window.show()

asyncio.set_event_loop(loop)


@asyncio.coroutine
def printInterval():

    inittime = loop.time()

    while 1:
        curtime = loop.time()
        elaptime = curtime - inittime
        #print(elaptime)
        if elaptime > 1:
            print("{}".format(elaptime))
            inittime = curtime

        yield from asyncio.sleep(.01) 

    #for i in range(80):
        #curtime = loop.time()
        #print("{} {}".format(i, curtime - inittime))
        #yield from asyncio.sleep(0.001)

        #time.sleep(0.1)

with loop:
    try:
        #loop.run_forever()
        loop.run_until_complete(printInterval())
    except:
        pass


