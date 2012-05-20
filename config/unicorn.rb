listen "/tmp/unicorn.sock"
worker_processes 4

stderr_path "/var/www/nodevent/shared/log/unicorn_stderr.log"
stdout_path "/var/www/nodevent/shared/log/unicorn_stdout.log"

after_fork do |server,worker|
  ActiveRecord::Base.connection.disconnect!
  # per-process listener ports for debugging/admin:
 
  # the negative :tries parameter indicates we will retry forever
  # waiting on the existing process to exit with a 5 second :delay
  # Existing options for Unicorn::Configurator#listen such as
  # :backlog, :rcvbuf, :sndbuf are available here as well.
  #server.listen(addr, :tries => -1, :delay => 6, :backlog => 128)
end
