# abcl-websocket-server
### _alejandrozf_

This is a very simple and minimal websocket server for ABCL using the https://github.com/webbit/webbit library

Usage:

This is a simple echo server

```
CL-USER> (require :abcl-asdf)
NIL
CL-USER> (require :abcl-contrib)
NIL
CL-USER> (asdf:load-system :quicklisp-abcl)
T
CL-USER> (ql:quickload :abcl-websocket-server)
To load "abcl-websocket-server":
  Load 1 ASDF system:
    abcl-websocket-server
; Loading "abcl-websocket-server"
[package abcl-websocket-server]
(:ABCL-WEBSOCKET-SERVER)
CL-USER> (in-package :abcl-websocket-server)
#<PACKAGE ABCL-WEBSOCKET-SERVER>
ABCL-WEBSOCKET-SERVER> (make-ws-server "/myws" 7000
                :on-open ((print "connected!"))
                :on-message ((send-text connection message)
                             (print message))
                :on-close ((print "I'm closing for now ...")))
#<java.util.concurrent.FutureTask java.util.concurrent.FutureTask@.... {74CB0F5E}>
ABCL-WEBSOCKET-SERVER>
```