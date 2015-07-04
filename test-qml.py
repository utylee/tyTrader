import sys
import asyncio

from PyQt5.QtCore import pyqtProperty, QCoreApplication, QObject, QUrl
from PyQt5.QtQml import qmlRegisterType, QQmlComponent, QQmlEngine
from quamash import QEventLoop

class Person(QObject):
    def __init__(self, parent=None):
        super().__init__(parent)

        self._name = ''
        self._shoeSize = 0

    @pyqtProperty('QString')
    def name(self):
        return self._name

    @name.setter
    def name(self, name):
        self._name = name

    @pyqtProperty(int)
    def shoeSize(self):
        return self._shoeSize

    @shoeSize.setter
    def shoeSize(self, shoeSize):
        self._shoeSize = shoeSize


app = QCoreApplication(sys.argv)
loop = QEventLoop(app)
asyncio.set_event_loop(loop)


with loop:
    loop.run_forever()



