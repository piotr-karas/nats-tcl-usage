package require nats

set ::conn [nats::connection new "MyNats"]
[$::conn logger]::setlevel info
$::conn configure -servers nats://localhost:4222
$::conn connect

# request - wait for response
proc makeRequest {} {
   incr ::reqCount
   set msg "Request $::reqCount"
   puts "Sending request: $msg"
   set response [$::conn request sample_subject.foo $msg]
   puts "Received response: $response"
   after 2000 makeRequest
}

after 1000 makeRequest

vwait forever