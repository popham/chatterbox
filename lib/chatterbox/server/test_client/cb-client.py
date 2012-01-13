from twisted.internet import reactor
from autobahn.websocket import *

class ChatterboxClientProtocol(WebSocketClientProtocol):
    def onConnect(self, connectionResponse):
        WebSocketClientProtocol.onConnect(self, connectionResponse)
        print "Connect response: %s" % (connectionResponse)

    def connectionMade(self):
        WebSocketClientProtocol.connectionMade(self)
        print 'Connected'

    def connectionLost(self, reason):
        WebSocketClientProtocol.connectionLost(self, reason)
        print "Lost Connection: %s" % (reason)

if __name__ == '__main__':
    url = createWsUrl('0.0.0.0', 9000);
    factory = WebSocketClientFactory(url, None, [], None, True)
    factory.protocol = ChatterboxClientProtocol
    connector = reactor.connectTCP('localhost', 9000, factory, 30, ('127.0.0.1', 3000))
    reactor.run()
#    connector = connectWS(factory)
#    print connector
