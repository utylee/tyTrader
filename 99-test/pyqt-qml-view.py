import sys
import asyncio

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


with loop:
    try:
        loop.run_forever()

    except:
        pass


