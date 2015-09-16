import sys
import asyncio
import time
import socket

from quamash import QEventLoop, QThreadExecutor
#from win32gui import SetWindowPos
#import win32con

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
from PyQt5.QtCore import QUrl, QObject, pyqtSlot
from PyQt5.QtQuick import QQuickView, QQuickWindow

app = QGuiApplication(sys.argv)
loop = QEventLoop(app)
#engine = QQmlApplicationEngine("main.qml")
engine = QQmlApplicationEngine()

rsock, wsock = socket.socketpair()


#아래에서 리턴받는 객체는 QQuickWindow였습니다. 
#window = engine.rootObjects()[0]
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

    @asyncio.coroutine
    def printInterval(self):

        inittime = loop.time()
        myRect = window.findChild(QObject, "myObject")
        myButton = window.findChild(QObject, "myButton")
        myRect.trigger.connect(self.onLoad)
        myButton.trigger.connect(self.onClicked)

        #assert myRect is not None
        #print(myRect)

        window.show()
       
        '''
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
            yield from asyncio.sleep(.1) 
        ''' 

        #for i in range(80):
            #curtime = loop.time()
            #print("{} {}".format(i, curtime - inittime))
            #yield from asyncio.sleep(0.001)

            #time.sleep(0.1)


class Dummy():
    def __init__(self, service):
        self.service = service

    @asyncio.coroutine
    def retFunc(self):
        print('retFunc:in')
        fut = asyncio.Future()
        asyncio.async(self.service.coro(fut))
        yield from fut
        print('!!!!!!!!!!!!')
        print('retFunc:after yield from')

    def reader(self):
        buf = rsock.recv(1)
        print(buf)
    


class Service(QObject):
    def __init__(self, loop, parent=None):
        self.loop = loop
        super().__init__(parent)
        self.dummy = Dummy(self)
        print(rsock)
        print(self.loop)
        #self.loop.add_reader(rsock, self.dummy.reader)
        self.loop.add_reader(rsock.fileno(), self.dummy.reader)
        #self.loop.add_reader(rsock, reader)
        #self.loop.add_reader(wsock.fileno(), reader)

    @asyncio.coroutine
    def coro(self, future):
        print('coro:in')
        self.future = future
        window = engine.rootObjects()[0]
        myObject = window.findChild(QObject, "myObject")
        myObject.funcSetResult()

    @pyqtSlot()
    def setResult(self):
        print('Service.setResult()')
        self.future.set_result('')
            

    @pyqtSlot()
    def onLoad(self):
        print('onLoad 를 실행했습니다 ^^')

    @pyqtSlot()
    def onButtonClicked(self):
        self.loop.call_soon(wsock.send, b'x')

    @pyqtSlot()
    def onClicked(self):
        print('onClicked 를 실행했습니다 ^^')
        #asyncio.ensure_future(self.dummy.retFunc())
        asyncio.async(self.dummy.retFunc())
        #yield from fut
        print('async execute')
        #yield from self.dummy.retFunc()
        #self.retFunc()
        print('헤헤')
        #loop.call_soon(self.retFunc)

    def retFunc(self):
        # qml 내의 함수를 invoke 합니다
        print('in retFunc')

        window = engine.rootObjects()[0]
        myObject = window.findChild(QObject, "myObject")
        myObject.funcRetClicked()
        '''
        with QThreadExecutor(1) as exec:
            window = engine.rootObjects()[0]
            myObject = window.findChild(QObject, "myObject")
            #loop.call_soon(myObject.funcRetClicked())
            #myObject.funcRetClicked()
            loop.run_in_executor(exec, myObject.funcRetClicked)
        '''

with loop:
    try:
        test = Test()
        service = Service(loop)

        #loop.run_forever()

        print('1')
        # rootObjects 실행전 context를 선언/추가해줍니다.
        ctx = engine.rootContext()
        ctx.setContextProperty('Service', service)

        engine.load("main.qml")
        window = engine.rootObjects()[0]
        #window.setContextProperty('Service', service)

        loop.run_until_complete(test.printInterval())
        loop.run_forever()
    except:
        pass


