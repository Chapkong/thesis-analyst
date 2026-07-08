import threading
import webbrowser
from pathlib import Path

from PIL import Image
from pystray import Icon, Menu, MenuItem
from werkzeug.serving import make_server

from app import app

HOST = "127.0.0.1"
PORT = 5000
ICON_PATH = Path(__file__).resolve().parent.parent / "assets" / "app.ico"
URL = f"http://{HOST}:{PORT}"


class ServerThread(threading.Thread):
    def __init__(self):
        super().__init__(daemon=True)
        self.server = make_server(HOST, PORT, app, threaded=True)

    def run(self):
        self.server.serve_forever()

    def shutdown(self):
        self.server.shutdown()


def main():
    try:
        server = ServerThread()
    except OSError:
        # already running elsewhere; just surface the existing instance
        webbrowser.open(URL)
        return
    server.start()
    threading.Timer(1.0, lambda: webbrowser.open(URL)).start()

    image = Image.open(ICON_PATH)

    def on_open(icon, item):
        webbrowser.open(URL)

    def on_quit(icon, item):
        server.shutdown()
        icon.stop()

    menu = Menu(
        MenuItem("브라우저 열기", on_open, default=True),
        MenuItem("종료", on_quit),
    )
    icon = Icon("논문 분석기", image, "논문 분석기", menu)
    icon.run()


if __name__ == "__main__":
    main()
