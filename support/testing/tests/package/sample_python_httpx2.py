import asyncio
from http.server import BaseHTTPRequestHandler, HTTPServer
from threading import Thread

import httpx2


class RequestHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        body = b'{"message": "Hello, Buildroot!"}'
        self.send_response(200)
        self.send_header("Content-Type", "application/json")
        self.send_header("Content-Length", str(len(body)))
        self.end_headers()
        self.wfile.write(body)


async def test_async(url):
    async with httpx2.AsyncClient(trust_env=False) as client:
        response = await client.get(url)
        assert response.status_code == 200
        assert response.json() == {"message": "Hello, Buildroot!"}


with HTTPServer(("127.0.0.1", 0), RequestHandler) as server:
    thread = Thread(target=server.serve_forever)
    thread.start()
    try:
        url = f"http://127.0.0.1:{server.server_port}/"
        with httpx2.Client(trust_env=False) as client:
            response = client.get(url)
            assert response.status_code == 200
            assert response.json() == {"message": "Hello, Buildroot!"}
        asyncio.run(test_async(url))
    finally:
        server.shutdown()
        thread.join()
