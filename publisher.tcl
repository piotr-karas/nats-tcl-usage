package require nats

set ::conn [nats::connection new "MyNats"]
[$::conn logger]::setlevel info
$::conn configure -servers nats://localhost:4222
$::conn connect

# publish message
proc publishMessage {} {
   incr ::msgCount
   set msg "Message $::msgCount"
   puts "Sending publish: $msg"
   $::conn publish sample_subject.foo $msg
   after 1000 publishMessage
}

after 1000 publishMessage

vwait forever