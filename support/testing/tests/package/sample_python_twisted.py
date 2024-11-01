from twisted.internet import protocol, reactor, endpoints
from twisted.web.client import readBody  # noqa: F401
from twisted.web import xmlrpc, server  # noqa: F401


class F(protocol.Factory):
    pass


endpoints.serverFromString(reactor, "tcp:1234").listen(F())
reactor.run()
