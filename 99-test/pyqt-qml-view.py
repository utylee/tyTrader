import sys
import asyncio
import time

from quamash import QEventLoop, QThreadExecutor
#from win32gui import SetWindowPos
#import win32con

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QUrl, QObject, pyqtSlot
from PyQt5.QtQuick import QQuickView, QQuickWindow

app = QGuiApplication(sys.argv)
loop = QEventLoop(app)
engine = QQmlApplicationEngine("main.qml")


#아래에서 리턴받는 객체는 QQuickWindow였습니다. 
window = engine.rootObjects()[0]
#window.show()

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

    

class Test():
    def __init__(self):
        self.count = 0

    def onClicked(self):
        ''' invoke 함수 실행'''
        print('onClicked 호출됨 ^^')

    def onLoad(self):
        ''' invoke 함수 실행'''
        print('onLoad 호출됨 ^^')

    #QQuickWindow.parent.
    @asyncio.coroutine
    def printInterval(self):

        inittime = loop.time()
        myRect = window.findChild(QObject, "myObject")
        myButton = window.findChild(QObject, "myButton")
        #myApp.trigger.connect(self.onLoad)
        #myRect.onLoad.connect(self.onLoad())
        #myRect.clicked.connect(self.onLoad())
        myRect.trigger.connect(self.onLoad)
        myButton.trigger.connect(self.onClicked)

        assert myRect is not None
        print(myRect)

        window.show()
        while 1:
            curtime = loop.time()
            elaptime = curtime - inittime
            #print(elaptime)
            if elaptime > 2:
                #print("{}".format(elaptime))
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

class Service(QObject):
    def __init__(self, parent=None):
        super().__init__(parent)

    @pyqtSlot()
    def onLoad(self):
        print('onLoad 를 실행했습니다 ^^')

with loop:
    try:
        test = Test()
        service = Service()

        window.setContextProperty('Service', service)
        #loop.run_forever()
        loop.run_until_complete(test.printInterval())
    except:
        pass


