
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
        while 1:
            #print('kkk')
            #print(loop.time())
            #print(datetime.datetime.now().strftime("%S"))
            sec = int(datetime.datetime.now().strftime("%S")) 
            #if int(datetime.datetime.now().strftime("$S")) < 90 :

            if sec <= 20 :
                obj.green(sec)

            elif sec <= 40 :
                obj.blue(sec)

            elif sec <= 50 :
                obj.orange(sec)

            elif sec <= 60 :
                obj.red(sec)

            yield from asyncio.sleep(1)


with loop:

    ctx = engine.rootContext()
    engine.load("progressor.qml")
    window = engine.rootObjects()[0]
    window.show()

    obj = window.findChild(QObject, "main")
    #obj.printa('56')

    prog = Progressor(obj)

    loop.run_until_complete(prog.proc())
    #loop.run_forever()
