jetty-rackup
============

For the newer projects we decided to switch from MRI to JRuby.  One of
the bigger questions is certainly the deployment.

Reading and trying all the warbler stuff, we had enough of packaging and
wanted to do it the Ruby/Sinatra way (with a standalone script, where
one can consciously start things like `run Sinatra::Application` from a
rackup script).

Embedding jetty is also mentioned in the jetty documentation "For many
applications, HTTP is just another interface protocol.  Jetty can easily
be embedded in such applications and products without adopting a WWW
centric application architecture."

So here is the solution:

* write your Rack based application as usual
* create a rackup script `config.ru` as usual; there is more information in
  the official tutorial
  <https://github.com/rack/rack/wiki/(tutorial)-rackup-howto>
* install jetty-rackup (this project), e.g.
  `gem install jetty-rackup` or
  `git clone git://github.com/geekq/jetty-rackup.git`
* from your application folder run `jetty-rackup`. You can also provide
  a path to non-standard rackup-script and the desired port
  number for the server to run.

Now your application runs inside jetty servlet container. Enjoy!


Example
-------
    $cat config.ru

    #\ -p 8765
    require 'rubygems'
    gem 'sinatra', '>= 1.0.0'
    require './my_app.rb'
    set :run, false # disable built-in sinatra web server
    set :environment, :development
    set :base_url, 'http://xxtrial' # custom application option
    run Sinatra::Application


Binaries
--------
The jetty and jruby-rack binaries are now provided for your convinience.
But you can also download a different version of them, if you wish, from
the official web sites of the respective projects:

* <http://jetty.codehaus.org/jetty/>
* <http://kenai.com/projects/jruby-rack/pages/Home>

The major gem version (7) now matches the used jetty version.

FAQ
---

> What's the best way to set max memory?

    jruby -J-Xmx2048m  /usr/local/lib/jetty-rackup/jetty-rackup config.ru

Tests
----

There are no automated tests for jetty-rackup. But there are some
example applications with rackup configuration. Just cd to the
particular example directory and run. E.g.

    cd examples/just_ruby/
    jetty-rackup
    firefox http://localhost:9292/stranger

jetty-rackup uses `config.ru` file from the current directory by
default.

What's new
----------
* 7.2.0
  + Add support for `Host` option. In addition to specifying port
    now a host ip can also be specified if e.g. you only wish to bind the
    server only to the loopback interface 127.0.0.1 and not to all IPs.
  + Add support for `pid` option - create pid file

See also
--------
For Rails deployment you may prefer jetty-rails
<http://jetty-rails.rubyforge.org/>


Copyright
---------
(c) 2009 Vodafone Group Services GmbH

(c) 2013 Vladimir Dobriakov


Author
------
Vladimir Dobriakov
<http://blog.geekq.net>, <http://www.mobile-web-consulting.de>

With contributions by [Leandro Silva](http://leandrosilva.com.br/),
Jason Rogers and erdeszt.

Further Credits
---------------
* Michal Hantl for the first working jetty based 'Hello world'
  application. <http://michal.hantl.cz/>
* Nick Sieger for the explanation of servlet context init params and of 
  course jruby-rack itself. <http://blog.nicksieger.com/>
* Thanks to [Nik](https://github.com/11xor6) for the Jetty 7.0 port.


