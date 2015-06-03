import sys
import asyncio
from quamash import QEventLoop

from PyQt5.QtCore import pyqtProperty, QCoreApplication, QObject, QUrl
from PyQt5.QtQml import qmlRegisterType, QQmlComponent, QQmlEngine



class Person(QObject):
    def __init__(self, parent=None):
        super().__init__(parent)

        self._name = ''
        self._shoeSize = 0

    @pyqtProperty('QString')
    def name(self):
        return self._name

    @pyqtProperty(int)
    def shoeSize(self):
        return self._shoeSize

    @name.setter
    def name(self, name):
        self._name = name

    @shoeSize.setter
    def shoeSize(self, shoeSize):
        self._shoeSize = shoeSize

app = QCoreApplication(sys.argv)
loop = QEventLoop(app)
asyncio.set_event_loop(loop)


qmlRegisterType(Person, 'People', 1, 0, 'Person')
engine = QQmlEngine()

component = QQmlComponent(engine)
component.loadUrl(QUrl('person.qml'))

person = component.create()

if person is not None:
    print("The person's name is {}".format(person.name))
    print("They wear a size {} shoe".format(person.shoeSize))

else:
    for error in component.errors():
        print(error.toString())


loop.run_forever()

