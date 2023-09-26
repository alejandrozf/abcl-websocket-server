;;;; abcl-websocket-server.lisp

(in-package #:abcl-websocket-server)

(defparameter *websocket-class*
    (java:jnew-runtime-class
     "ABCLWebsocketServer"
     :constructors (list
                    (list (list "java.net.InetSocketAddress")
                          (lambda (this address)
                            (print this)
                            (print address))
                          (list 1)))
     :superclass "org.java_websocket.server.WebSocketServer"
     :methods (list
               (list "onMessage" :void '("org.java_websocket.WebSocket" "java.nio.ByteBuffer")
                     (lambda (this message)
                       (format t "var message=~a~%" message)))
               (list "onOpen" :void '("org.java_websocket.WebSocket" "org.java_websocket.handshake.ClientHandshake")
                     (lambda (this conn handshake)
                       (let ((get-remote-socket-addr-method
                               (java:jmethod "org.java_websocket.WebSocket" "getRemoteSocketAddress")))
                         (format t "new connection from ~a~%" (java:jcall get-remote-socket-addr-method conn)))))
               (list "onError" :void '("org.java_websocket.WebSocket" "java.lang.Exception")
                     (lambda (this conn exception)
                       (format t "an exception ocurred ~a~%" exception)))
               (list "onStart" :void '()
                     (lambda (this)
                       (print "starting..."))))))
