import os

import varlink

service = varlink.Service(interface_dir=os.path.dirname(__file__))


class ServiceRequestHandler(varlink.RequestHandler):
    service = service


@service.interface("org.example.test")
class Example:
    def Ping(self, ping):
        return {"pong": ping}


def run_server(address):
    with varlink.ThreadingServer(address, ServiceRequestHandler) as server:
        print("Listening on", server.server_address)
        server.serve_forever()


run_server("unix:@test")
