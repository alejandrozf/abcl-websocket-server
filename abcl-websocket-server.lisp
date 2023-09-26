;;;; abcl-websocket-server.lisp

(in-package #:abcl-websocket-server)


(defparameter *current-server* nil)


(defparameter *servers* '())


(defun stop-server (server)
  (java:jcall (java:jmethod "org.webbitserver.netty.NettyWebServer" "stop")
              server))


(defun add-new-server (server)
  (setf *current-server* server)
  (push server *servers*)
  server)


(defmacro make-ws-server (path port &key on-open on-message on-ping on-pong on-close)
  `(java:jcall
    (java:jmethod "org.webbitserver.netty.NettyWebServer" "start")
    (java:jcall
     (java:jmethod "org.webbitserver.netty.NettyWebServer"
                   "add"
                   "java.lang.String"
                   "org.webbitserver.WebSocketHandler")
     (add-new-server
      (java:jstatic (java:jmethod "org.webbitserver.WebServers" "createWebServer" "int")
                    "org.webbitserver.WebServers" ,port))
     ,path
     (java:jinterface-implementation
      "org.webbitserver.WebSocketHandler"
      "onOpen" (lambda (connection)
                 (progn ,@on-open))
      "onClose" (lambda (connection)
                  (progn ,@on-close))
      "onMessage" (lambda (connection message)
                    (progn ,@on-message))
      "onPing" (lambda (connection message)
                 (progn ,@on-ping))
      "onPong" (lambda (connection message)
                 (progn ,@on-pong))))))
