
# 영웅문3 위에 놓여 1분봉 마감시점을 표시해주는 프로그래스 바 어플입니다. 

import os
import sys
import asyncio
import time
import datetime
#import socket

from quamash import QEventLoop, QThreadExecutor
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
# 이 라인이 없으면 Qt 이미지 로드 오류 어쩌고가 뜹니다
from PyQt5.QtQuick import QQuickView, QQuickWindow
from PyQt5.QtCore import QObject

app = QGuiApplication(sys.argv)
loop = QEventLoop(app)
engine = QQmlApplicationEngine()

asyncio.set_event_loop(loop)

class Progressor:
    def __init__(self, obj):
        self.obj = obj

    @asyncio.coroutine
    def proc(self):
        #print("proc started")
        while 1:
            sec = datetime.datetime.now().second

            if sec < 20 :
                self.obj.green(sec)

            elif sec < 40 :
                self.obj.blue(sec)

            elif sec < 50 :
                self.obj.orange(sec)

            elif sec < 60 :
                self.obj.red(sec)

            else :
                self.obj.green(sec)

            sleeptime = 1000000 - datetime.datetime.now().microsecond
            yield from asyncio.sleep(round(sleeptime * 0.000001, 2))


with loop:

    ctx = engine.rootContext()
    engine.load("progressor.qml")
    #engine.load("progressor_multiple.qml")
    #window = engine.rootObjects()[0]
    #window = engine.rootObjects()[0].findChild("wnd1")
    #root = engine.rootObjects()[0].findChild(QObject, "rootObj")
    #root = engine.rootObjects()[0]

    #window = engine.rootObjects()[0].findChild(QObject, "wnd")
    window = engine.rootObjects()[0].findChild(QObject, "wnd_dummy")
    window1 = engine.rootObjects()[0].findChild(QObject, "wnd1")
    window2 = engine.rootObjects()[0].findChild(QObject, "wnd2")

    window.show()
    window1.show()
    window2.show()

    obj = window.findChild(QObject, "main")
    obj1 = window1.findChild(QObject, "main1")
    obj2 = window2.findChild(QObject, "main2")

    prog = Progressor(obj)
    prog1 = Progressor(obj1)
    prog2 = Progressor(obj2)

    window.hide()

    #loop.run_until_complete(prog.proc())
    asyncio.async(prog.proc())
    asyncio.async(prog1.proc())
    asyncio.async(prog2.proc())
    
    #loop.async(prog1.proc())

    loop.run_forever()
