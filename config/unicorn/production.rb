listen "/tmp/nodeventdemo-unicorn.sock"
worker_processes 2

working_directory "/var/www/nodeventdemo/current"

pid "/var/www/nodeventdemo/shared/pids/unicorn.pid"
stderr_path "/var/www/nodeventdemo/shared/log/unicorn_stderr.log"
stdout_path "/var/www/nodeventdemo/shared/log/unicorn_stdout.log"

after_fork do |server,worker|
  #ActiveRecord::Base.connection.disconnect!
  # per-process listener ports for debugging/admin:
  old_pid = "#{server.config[:pid]}.oldbin"
  begin
    sig = :QUIT 
    Process.kill(sig, File.read(old_pid).to_i)
  rescue Errno::ENOENT, Errno::ESRCH
  end
 
  # the negative :tries parameter indicates we will retry forever
  # waiting on the existing process to exit with a 5 second :delay
  # Existing options for Unicorn::Configurator#listen such as
  # :backlog, :rcvbuf, :sndbuf are available here as well.
  #server.listen(addr, :tries => -1, :delay => 6, :backlog => 128)
end
