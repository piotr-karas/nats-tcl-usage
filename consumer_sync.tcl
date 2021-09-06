package require nats

set ::conn [nats::connection new "MyNats"]
[$::conn logger]::setlevel info
$::conn configure -servers nats://localhost:4222
$::conn connect

set ::jet [$::conn jet_stream]

# request - wait for response
proc consumeSync {} {
   incr ::reqCount
   puts "Trying to consume $::reqCount" ;# without timeout
   if {[catch {
      set consumed [$::jet consume "MY_STR" "my_con"]
   } err]} {
      # timeout
      puts "Error consuming: $err"
   } else {
      # got message
      puts "Consumed message: [lindex $consumed 0]"
      puts "Acknowledging... (on address [lindex $consumed 1])"

      $::jet ack [lindex $consumed 1]
      puts "Acknowledged"
   }

   after 2000 consumeSync
}

after 1000 consumeSync

vwait forever