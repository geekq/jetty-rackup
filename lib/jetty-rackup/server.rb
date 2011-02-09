class Rack::Handler::Jetty
  def self.run(rackup_content, options={})
    Dir["#{File.dirname(__FILE__)}/../../jars/*.jar"].each { |jar| require jar }

    include_class 'javax.servlet.http.HttpServlet'
    include_class 'org.mortbay.jetty.Server'
    include_class 'org.mortbay.jetty.servlet.Context'
    include_class 'org.mortbay.jetty.servlet.ServletHolder'
    include_class 'org.jruby.rack.servlet.ServletRackContext'
    include_class 'org.mortbay.jetty.handler.ResourceHandler'
    include_class 'org.mortbay.jetty.handler.DefaultHandler'
    include_class 'org.mortbay.jetty.handler.HandlerList'
    include_class 'org.mortbay.jetty.handler.ContextHandlerCollection'
    include_class 'org.mortbay.jetty.servlet.DefaultServlet'

    jetty = org.mortbay.jetty.Server.new options[:Port]

    context = org.mortbay.jetty.servlet.Context.new(nil, "/", org.mortbay.jetty.servlet.Context::NO_SESSIONS)
    context.add_filter("org.jruby.rack.RackFilter", "/*", org.mortbay.jetty.Handler::DEFAULT)
    context.set_resource_base(File.dirname(__FILE__))
    context.add_event_listener(org.jruby.rack.RackServletContextListener.new)

    context.set_init_params(java.util.HashMap.new(
      'org.mortbay.jetty.servlet.Default.relativeResourceBase' => '/public',
      'rackup' => rackup_content,
      'jruby.max.runtimes' => '1'))
      
    context.add_servlet(org.mortbay.jetty.servlet.ServletHolder.new(
      org.mortbay.jetty.servlet.DefaultServlet.new), "/")
    
    JRuby.runtime.jruby_class_loader.add_url(java.io.File.new("WEB-INF/classes").to_url)

    Dir["WEB-INF/lib/**/*.jar"].each do |jar|
      JRuby.runtime.jruby_class_loader.add_url(java.io.File.new(jar).to_url)
    end
    
    jetty.set_handler(context)
    jetty.start
  end
end