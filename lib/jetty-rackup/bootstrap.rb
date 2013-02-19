#
# Option parsing is based on the original rackup script.
#

automatic = false
server_type = nil
env = "development"
options = {:Port => 9292, :Host => "0.0.0.0", :AccessLog => []}

opts = OptionParser.new("", 24, '  ') { |opts|
  opts.banner = "Usage: jetty_rackup [ruby options] [rack options] [rackup config]"

  opts.separator ""
  opts.separator "Ruby options:"

  lineno = 1
  opts.on("-e", "--eval LINE", "evaluate a LINE of code") { |line|
    eval line, TOPLEVEL_BINDING, "-e", lineno
    lineno += 1
  }

  opts.on("-d", "--debug", "set debugging flags (set $DEBUG to true)") {
    $DEBUG = true
  }
  opts.on("-w", "--warn", "turn warnings on for your script") {
    $-w = true
  }

  opts.on("-I", "--include PATH",
          "specify $LOAD_PATH (may be used more than once)") { |path|
    $LOAD_PATH.unshift(*path.split(":"))
  }

  opts.on("-r", "--require LIBRARY",
          "require the library, before executing your script") { |library|
    require library
  }

  opts.separator ""
  opts.separator "Rack options:"
  opts.on("-s", "--server SERVER", "serve using SERVER (only jetty is supported)") { |s|
    server_type = s
  }

  opts.on("-o", "--host HOST", "listen on HOST (default: 0.0.0.0)") { |host|
    options[:Host] = host
  }

  opts.on("-p", "--port PORT", "use PORT (default: 9292)") { |port|
    options[:Port] = port.to_i
  }

  opts.on("-E", "--env ENVIRONMENT", "use ENVIRONMENT for defaults (default: development)") { |e|
    env = e
  }

  opts.on("-D", "--daemonize", "run daemonized in the background - does not work with JRuby - please use a wrapper shell script") { |d|
    daemonize = d ? true : false
  }

  opts.on("-P", "--pid FILE", "file to store PID") { |file|
    file = File.expand_path(file)
    puts "Creating PID file '#{file}'"
    File.write(file, java.io.File.new('/proc/self').canonical_file.name)
  }

  opts.separator ""
  opts.separator "Common options:"

  opts.on_tail("-h", "--help", "Show this message") do
    puts opts
    exit
  end

  opts.on_tail("--version", "Show version") do
    puts "Rack #{Rack.version}"
    exit
  end

  opts.parse! ARGV
}

require 'pp'  if $DEBUG

config = ARGV[0] || "config.ru"
if !File.exist? config
  abort "configuration #{config} not found"
end

if config =~ /\.ru$/
  rackup = File.read(config)
  if rackup[/^#\\(.*)/]
    opts.parse! $1.split(/\s+/)
  end
  #rackup << "\n  set :environment, :#{env}" if env
  rackup.gsub! /set :environment, .*?$/, "set :environment, :#{env}" if env
else
  abort "configuration file with .ru extention expected, was '#{config}'"
end

#
# Boot the server.
#

unless server = Rack::Handler.get(server_type)
  server = Rack::Handler::Jetty
end

p server  if $DEBUG

if $DEBUG
  pp app
  pp rackup
end

puts "---- rackup"
puts rackup
puts "---- "

server.run rackup, options
