;;;; package.lisp

(defpackage #:abcl-websocket-server
  (:use #:cl)
  (:export
   #:*current-server*
   #:*servers*
   #:stop-server
   #:send-text
   #:make-ws-server))
