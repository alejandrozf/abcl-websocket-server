;;;; abcl-websocket-server.lisp

(in-package #:abcl-websocket-server)

(java:jnew-runtime-class
 "ABCLWebsocketServer"
 :superclass "org.java_websocket.server.WebSocketServer"
 :methods (list
           (list "onOpen" :void '("org.java_websocket.WebSocket" "org.java_websocket.handshake.ClientHandshake")
                 (lambda (this conn handshake)
                   (let ((get-remote-socket-addr-method
                           (java:jmethod "org.java_websocket.WebSocket" "getRemoteSocketAddress")))
                    (format t "new connection from ~a~%" (java:jcall get-remote-socket-addr-method conn)))))))
