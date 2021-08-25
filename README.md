# nats-tcl-usage

Simple usage of nats library for tcl.

Prerequests:
- make sure nats library is available (eg. add it to ::auto_path, "lappend ::auto_path C:\\.....\\nats-tcl")
- make sure NATS server is running on port 4222

Run:
- "tclsh subscriber.tcl" in order to start subscriber - it will wait for messages and requestes.
- "tclsh publisher.tcl" to test publishing messages.
- "tclsh requester.tcl" to test requests with reponses.