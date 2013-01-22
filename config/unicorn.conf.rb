# encoding: utf-8

# See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# See also http://unicorn.bogomips.org/examples/unicorn.conf.rb for
require 'pathname'

# 環境ごとの設定
#--------------------------------------------------------
config  = {}
config["development"] = {
  :port => 3000,
  :worker_processes => 2,
  :working_directory => Pathname.new(File.dirname(__FILE__) + "/..").realpath
}
config["production"] = {
  :port => 8010,
  :worker_processes => 2,
  :working_directory => "#{ENV['HOME']}/approot"
}
#--------------------------------------------------------
rails_env = ENV['RAILS_ENV'] || 'development'
worker_processes config[rails_env][:worker_processes]
working_directory config[rails_env][:working_directory]
port=config[rails_env][:port]
listen port, :tcp_nopush => true
timeout 300
pid "tmp/pids/unicorn.pid"
preload_app false
stderr_path "log/unicorn.log"
stdout_path "log/unicorn.log"

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!

  # 古いマスタープロセスを停止させる
  begin
    old_pid_file= "tmp/pids/unicorn.pid.oldbin"
    if File.exist?(old_pid_file)
      Process.kill("QUIT", File.read(old_pid_file).to_i)
    end
  rescue Errno::ENOENT, Errno::ESRCH => e
    puts "old master quit failed!: #{e.message}"
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection

  # 古いマスタープロセスを停止させる
  begin
    old_pid_file= "tmp/pids/unicorn.pid.oldbin"
    if File.exist?(old_pid_file)
      Process.kill("QUIT", File.read(old_pid_file).to_i)
    end
  rescue Errno::ENOENT, Errno::ESRCH => e
    puts "old master quit failed!: #{e.message}"
  end

end
