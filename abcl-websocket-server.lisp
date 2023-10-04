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


(defun send-text (connection message)
  (java:jcall
   (java:jmethod "org.webbitserver.netty.NettyWebSocketConnection"
                 "send" "java.lang.String") connection message))


(defmacro make-ws-server (path port &key on-open on-message on-ping on-pong on-close (static-path "/tmp"))
  `(java:jcall
    (java:jmethod "org.webbitserver.netty.NettyWebServer" "start")
    (java:jcall
     (java:jmethod "org.webbitserver.netty.NettyWebServer" "add" "org.webbitserver.HttpHandler")
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
                  (declare (ignorable connection))
                  (progn ,@on-open))
       "onClose" (lambda (connection)
                   (declare (ignorable connection))
                   (progn ,@on-close))
       "onMessage" (lambda (connection message)
                     (declare (ignorable connection message))
                     (progn ,@on-message))
       "onPing" (lambda (connection message)
                  (declare (ignorable connection message))
                  (progn ,@on-ping))
       "onPong" (lambda (connection message)
                  (declare (ignorable connection message))
                  (progn ,@on-pong))))
     (java:jnew "org.webbitserver.handler.StaticFileHandler" ,static-path))))
