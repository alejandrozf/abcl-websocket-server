;;;; abcl-websocket-server.asd

(asdf:defsystem #:abcl-websocket-server
  :description "A websocket server for ABCL"
  :author "alejandrozf"
  :version "0.0.1"
  :serial t
  :components ((:mvn "org.webbitserver/webbit/0.4.15")
               (:file "package")
               (:file "abcl-websocket-server")))
