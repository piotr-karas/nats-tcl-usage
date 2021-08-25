package require nats

set ::conn [nats::connection new "MyNats"]
[$::conn logger]::setlevel info
$::conn configure -servers nats://localhost:4222
$::conn connect

proc asyncReqCallback {timedOut msg} {
   if {$timedOut} {
      throw error "Request time out!"
   }
   puts "Received async response: $msg"
}

# request - wait for response
proc makeRequest {} {
   incr ::reqCount
   set msg "Request $::reqCount"
   puts "Sending request: $msg"
   $::conn request sample_subject.foo $msg -timeout 1000 -callback asyncReqCallback
   after 2000 makeRequest
}

after 1000 makeRequest

vwait forever