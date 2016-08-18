
# 영웅문3 위에 놓여 1분봉 마감시점을 표시해주는 프로그래스 바 어플입니다. 

import os
import sys
import asyncio
import time
#import socket

from quamash import QEventLoop, QThreadExecutor
from PyQt5.QtGui import QGuiApplication
from PyQt5.QtQml import QQmlApplicationEngine
# 이 라인이 없으면 Qt 이미지 로드 오류 어쩌고가 뜹니다
from PyQt5.QtQuick import QQuickView, QQuickWindow

app = QGuiApplication(sys.argv)
loop = QEventLoop(app)
engine = QQmlApplicationEngine()

asyncio.set_event_loop(loop)

with loop:
    print('progressor')

    ctx = engine.rootContext()
    engine.load("progressor.qml")
    window = engine.rootObjects()[0]
    window.show()

    loop.run_forever()
