lappend ::auto_path C:\\Projekty\\GIT\\nats-tcl
package require nats

set ::conn [nats::connection new "MyNats"]
[$::conn logger]::setlevel info
$::conn configure -servers nats://localhost:4222
$::conn connect

proc onMessage {subject message replyTo} {
   if {$replyTo eq ""} {
      # don't reply
      puts "Received message \"$message\" on subject $subject."
      return
   }

   puts "Received request \"$message\" on subject $subject. Replying.."
   
   # it is "request", so answer it using "publish"
   $::conn publish $replyTo "My reply to message - $message"
   return
}

$::conn subscribe "sample_subject.*" -callback onMessage

vwait forever
