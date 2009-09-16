jetty-rackup
============

For the newer projects we decided to switch from MRI to JRuby.  One of
the bigger questions is certainly the deployment.

Reading and trying all the warbler stuff, we had enough of packaging and
wanted to do it the Ruby/Sinatra way (with a standalone script, where
one can conciously start things like `run Sinatra::Application` from a
rackup script).

Embedding jetty is also mentioned in the jetty documentation "For many
applications, HTTP is just another interface protocol.  Jetty can easily
be embedded in such applications and products without adopting a WWW
centric application architecture."

So here is the solution:

* write your Rack based application as usual
* create a rackup script `config.ru` as usual
* install jetty-rackup (this project), e.g. 
  `git clone git://github.com/geekq/jetty-rackup.git`
* run your application from the command line inside jetty servlet container
  from your application folder with `jetty-rackup`


Binaries
--------
The jetty and jruby-rack binaries are now provided for your convinience.
But you can also download a different version of them if you wish from
the official web sites of the respective projects:

* http://jetty.mortbay.com/
* http://kenai.com/projects/jruby-rack/pages/Home


TODO
----
* package as gem
* support all the Rack settings like custom port number etc.


Credits
-------
* Michal Hantl for the first working jetty based 'Hello world'
  application. http://michal.hantl.cz/
* Nick Sieger for jruby-rack and the explanation of servlet context init
  params. http://blog.nicksieger.com/


Copyright
---------
(c) 2009 Vodafone


Author
-----
Vladimir Dobriakov http://blog.geekq.net, http://www.innoq.com/blog/vd

