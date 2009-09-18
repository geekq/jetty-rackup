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
* create a rackup script `config.ru` as usual; there is more information in
  the official tutorial http://wiki.github.com/rack/rack/tutorial-rackup-howto
* install jetty-rackup (this project), e.g. 
  `git clone git://github.com/geekq/jetty-rackup.git`
* from your application folder run `jetty-rackup`. You can also provide
  a path to non-standard rackup-script and the desired port
  number for the server to run.

Now your application runs inside jetty servlet container. Enjoy!


Binaries
--------
The jetty and jruby-rack binaries are now provided for your convinience.
But you can also download a different version of them, if you wish, from
the official web sites of the respective projects:

* http://jetty.mortbay.com/
* http://kenai.com/projects/jruby-rack/pages/Home


TODO
----
* package as gem
* demonization facility


Credits
-------
* Michal Hantl for the first working jetty based 'Hello world'
  application. http://michal.hantl.cz/
* Nick Sieger for the explanation of servlet context init params and of 
  course jruby-rack itself. http://blog.nicksieger.com/


See also
--------
For Rails deployment you may prefer jetty-rails 
http://jetty-rails.rubyforge.org/


Copyright
---------
(c) 2009 Vodafone


Author
------
Vladimir Dobriakov, innoQ Deutschland GmbH 
http://blog.geekq.net, http://www.innoq.com/blog/vd


Feedback 
-------- 
jetty_rackup is very new.  Please let me know, it something, especially
advandced rack configuration, does not work. Please also let me know if
your were able to successfully run a web server using jetty_rackup. You
can use github messaging.

