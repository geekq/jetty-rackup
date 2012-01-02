class Rack::Handler::Jetty
  def self.run(rackup_content, options={})
    Dir["#{File.dirname(__FILE__)}/../../jars/*.jar"].each { |jar| require jar }

    include_class 'javax.servlet.http.HttpServlet'
    include_class 'org.eclipse.jetty.server.Server'
    include_class 'org.eclipse.jetty.servlet.ServletContextHandler'
    include_class 'org.eclipse.jetty.servlet.ServletHolder'
    include_class 'org.jruby.rack.servlet.ServletRackContext'
    include_class 'org.eclipse.jetty.server.handler.ResourceHandler'
    include_class 'org.eclipse.jetty.server.handler.DefaultHandler'
    include_class 'org.eclipse.jetty.server.handler.HandlerList'
    include_class 'org.eclipse.jetty.server.handler.ContextHandlerCollection'
    include_class 'org.eclipse.jetty.servlet.DefaultServlet'

    jetty = org.eclipse.jetty.server.Server.new options[:Port]

    context = org.eclipse.jetty.servlet.ServletContextHandler.new(nil, "/", org.eclipse.jetty.servlet.ServletContextHandler::NO_SESSIONS)
    context.add_filter("org.jruby.rack.RackFilter", "/*", 0)
    context.set_resource_base(File.dirname(__FILE__))
    context.add_event_listener(org.jruby.rack.RackServletContextListener.new)

    context.set_init_parameter('org.eclipse.jetty.servlet.Default.relativeResourceBase', '/public')
    context.set_init_parameter('rackup', rackup_content)
    context.set_init_parameter('jruby.max.runtimes', '1')

    context.add_servlet(org.eclipse.jetty.servlet.ServletHolder.new(
                            org.eclipse.jetty.servlet.DefaultServlet.new), "/")

    JRuby.runtime.jruby_class_loader.add_url(java.io.File.new("WEB-INF/classes").to_url)

    Dir["WEB-INF/lib/**/*.jar"].each do |jar|
      JRuby.runtime.jruby_class_loader.add_url(java.io.File.new(jar).to_url)
    end

    jetty.set_handler(context)
    jetty.start
  end
end
