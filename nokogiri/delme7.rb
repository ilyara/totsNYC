Signal.trap(0, proc { puts "Terminating: #{$$} at #{Time.now.localtime}" })
#Signal.trap("CLD")  { puts "Child died" }
#fork && Process.wait
