import asyncio
import os
import tempfile
from collections.abc import Callable
from types import TracebackType
from typing import TypeAlias
from wsgiref.types import StartResponse

from asgiref.typing import HTTPScope, HTTPRequestEvent, ASGIVersions

from servestatic import ServeStatic, ServeStaticASGI

CONTENT = b"ServeStatic works on Buildroot.\n"

_ExcInfo: TypeAlias = tuple[type[BaseException], BaseException, TracebackType]
_OptExcInfo: TypeAlias = _ExcInfo | tuple[None, None, None]


def assert_response_ok(status, headers, body):
    assert status == 200
    assert headers["content-length"] == str(len(CONTENT))
    assert headers["content-type"].startswith("text/plain")
    assert body == CONTENT


def test_wsgi(content_directory):
    app = ServeStatic(None, root=content_directory)
    response_data = {}

    class DummyStartResponse(StartResponse):
        def __call__(self, status: str, headers: list[tuple[str, str]], exc_info: _OptExcInfo | None = None, /) -> \
                Callable[[bytes], object]:
            response_data["status"] = int(status.split()[0])
            response_data["headers"] = {
                key.lower(): value for key, value in headers
            }
            return super().__call__(status, headers, exc_info)

    start_response = DummyStartResponse()

    environ_test_request = {
        "PATH_INFO": "/test_content.txt",
        "REQUEST_METHOD": "GET",
    }
    response = app(environ_test_request, start_response)
    try:
        body = b"".join(response)
    finally:
        close = getattr(response, "close", None)
        if callable(close):
            close: Callable[None]
            close()

    assert_response_ok(
        response_data["status"], response_data["headers"], body
    )


async def test_asgi(content_directory):
    app = ServeStaticASGI(None, root=content_directory)
    messages_received_from_application = []

    async def receive() -> HTTPRequestEvent:
        return HTTPRequestEvent(
            type="http.request",
            body=b"",
            more_body=False,
        )

    # will be invoked when the application "sends" data back -> append all sent data to the messages list
    async def send(message):
        messages_received_from_application.append(message)

    # run the test request
    scope_test_request = HTTPScope(
        type="http",
        asgi=ASGIVersions(
            version="3.0",
            spec_version="2.5"
        ),
        http_version="1.1",
        method="GET",
        scheme="http",
        path="/test_content.txt",
        raw_path=b"/hello.txt",
        query_string=b"",
        root_path="",
        headers=[],
        client=("127.0.0.1", 12345),
        server=("127.0.0.1", 80),
        extensions=None
    )
    await app(scope_test_request, receive, send)

    # first segment contains the headers
    message_with_headers = messages_received_from_application[0]

    # convert headers into correct form for assert_response_ok
    headers = {
        key.decode(): value.decode() for key, value in message_with_headers["headers"]
    }

    # collect content of all "body" type messages
    body = b"".join(
        message.get("body", b"")
        for message in messages_received_from_application
        if message["type"] == "http.response.body"
    )

    # assert everything works as expected
    assert_response_ok(message_with_headers["status"], headers, body)


with tempfile.TemporaryDirectory() as tmp_content_directory:
    with open(os.path.join(tmp_content_directory, "test_content.txt"), "wb") as static_file:
        static_file.write(CONTENT)
    test_wsgi(tmp_content_directory)
    asyncio.run(test_asgi(tmp_content_directory))
