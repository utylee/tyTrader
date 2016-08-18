import sys
import asyncio
import time
import socket

from quamash import QEventLoop, QThreadExecutor
#from win32gui import SetWindowPos
#import win32con

from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine, QJSValue
from PyQt5.QtCore import QUrl, QObject, pyqtSlot
# 이 라인이 없으면 Qt 이미지 로드 오류 어쩌고가 뜹니다
from PyQt5.QtQuick import QQuickView, QQuickWindow

app = QGuiApplication(sys.argv)
loop = QEventLoop(app)
#engine = QQmlApplicationEngine("main.qml")
engine = QQmlApplicationEngine()

rsock, wsock = socket.socketpair()
rsock2, wsock2 = socket.socketpair()


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
    
    def reader2(self):
        buf = rsock2.recv(1)
        print("{}-{}".format("reader2", buf))


class Service(QObject):
    def __init__(self, loop, parent=None):
        self.loop = loop
        super().__init__(parent)
        self.dummy = Dummy(self)
        print(rsock)
        print(self.loop)

        # QEventLoop 즉, quamash를 통한 loop에서는add_reader를 할 때
        # sock.fileno()를 통해야만 한다는 사실을 알게 되었습니다.
        self.loop.add_reader(rsock.fileno(), self.dummy.reader)
        self.loop.add_reader(rsock2.fileno(), self.dummy.reader2)
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
    def onButtonClicked2(self):
        self.loop.call_soon(wsock2.send, b'x')

    @pyqtSlot()
    def onButtonClicked(self):

        window = engine.rootObjects()[0]
        ctx = engine.rootContext()
        print(window)
        # [ ] findChild가 아닌 뭘로 해야할까
        #   --> 그냥 qml내의 object에서 호출 clone을 만들어준다던가 하는 식으로 가기로 결정. 시간 소모 그만
        
        #logic = window.findChild(QObject, "Logic")
        #children = window.findChildren(QObject)
        children = ctx.findChildren(QObject)
        print("children : {}".format(children))
        c = 0
        for i in children:
            print("{} : {}".format(c, i.objectName()))
            c = c+ 1
        #logic = engine.rootContext().findChild(QObject, "Logic")
        myObject = window.findChild(QObject, "myObject")
        #print("Logic : {}".format(logic))
        print("myObject: {}".format(myObject))
        #print(myObject)
        #if logic:
        #    logic.testjs()
        QJSValue(testjs).call()
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

        #engine.load("main.qml")
        engine.load("qml/tytrader.qml")
        window = engine.rootObjects()[0]
        #window.setContextProperty('Service', service)

        loop.run_until_complete(test.printInterval())
        loop.run_forever()
    except:
        pass


