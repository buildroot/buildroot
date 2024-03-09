#! /usr/bin/env python3
#
# This is a test application for PyQt5. It is showing a text label and
# a "quit" button. The text of the label can be set with the first
# (non-Qt) command line argument. A timer will send a click signal to
# the quit button after 3 seconds. When quitting, the text of the
# label is saved in a "message.txt" file in the current working
# directory.

import sys

from PyQt5.QtCore import PYQT_VERSION_STR, QFile, QIODevice, QT_VERSION_STR, QTextStream, QTimer, Qt
from PyQt5.QtWidgets import QApplication, QLabel, QPushButton, QVBoxLayout, QWidget


class TestApp(QWidget):

    def __init__(self, message, parent=None):
        super(TestApp, self).__init__(parent)

        self.label = QLabel(message)
        self.label.setAlignment(Qt.AlignCenter)

        self.button = QPushButton("Quit")
        self.button.clicked.connect(self.on_button_clicked)

        self.layout = QVBoxLayout()
        self.layout.addWidget(self.label)
        self.layout.addWidget(self.button)

        self.setLayout(self.layout)

        self.timer = QTimer()
        self.timer.timeout.connect(self.button.click)

    def on_button_clicked(self):
        self.save_message()
        app.quit()

    def save_message(self):
        f = QFile("message.txt")
        if f.open(QIODevice.WriteOnly):
            QTextStream(f) << (self.label.text() + '\n')
        f.close()


if __name__ == "__main__":
    print("PyQt5 test for Buildroot")
    print(f"Qt version {QT_VERSION_STR}")
    print(f"PyQt version {PYQT_VERSION_STR}")

    msg = "Hello World"
    app = QApplication(sys.argv)
    args = app.arguments()
    if len(args) > 1:
        msg = args[1]
    testApp = TestApp(message=msg)
    testApp.show()
    testApp.timer.start(3000)
    sys.exit(app.exec())
