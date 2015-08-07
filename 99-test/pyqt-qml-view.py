import sys
import asyncio
import time

from quamash import QEventLoop, QThreadExecutor
#from win32gui import SetWindowPos
#import win32con

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QUrl
from PyQt5.QtQuick import QQuickView, QQuickWindow

app = QGuiApplication(sys.argv)
loop = QEventLoop(app)
engine = QQmlApplicationEngine("main.qml")


#아래에서 리턴받는 객체는 QQuickWindow였습니다. 
window = engine.rootObjects()[0]
window.show()

asyncio.set_event_loop(loop)



# 바 클래스를 스케치해봅니다.
class CCandle:
    def __init__(self):
        self.price = 1000
        self.time = 0 

    # 가격을 설정합니다.
    def setPrice(self, price):
        # qml 상의 메써드를 호출합니다
        pass


#QQuickWindow.parent.
@asyncio.coroutine
def printInterval():

    inittime = loop.time()

    while 1:
        curtime = loop.time()
        elaptime = curtime - inittime
        #print(elaptime)
        if elaptime > 2:
            print("{}".format(elaptime))
            inittime = curtime
            #loop.call_soon_threadsafe(activate)

            #천신만고 끝에 activeWindow 대신 아래 함수를 사용해야한다는 것을
            # 깨달았습니다.
            window.requestActivate()

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


