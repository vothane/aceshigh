aceshigh
========

**ac** tive **e** ngine for **s** earch in **h** eavy &amp; l **igh** t ruby web apps (rails, sinatra, ...)

Exposes the Lucene Java libraries to any implementation of Ruby by using JRuby and DRb.


demo

open a JRuby terminal (if using rvm: rvm use jruby or chruby ruby if using  chruby)

go inside the aceshigh dir and type

```
jruby aceshigh_server.rb druby://localhost:12345 
```

should get output of

```
druby://localhost:12345
```

search server is running

## Example Usage

now open a second terminal with MRI Ruby (rvm use ruby 1.9.3 or 2.0.0)

type

```
irb
```

in irb type

```
> require 'drb/drb'
> client = DRbObject.new_with_uri('druby://localhost:12345')
> client.index({:name => "Miles", :hobby => "snowboarding"})
> client.index({:name => "Miles", :hobby => "couch-surfing"})
> client.index({:name => "Lisa",  :hobby => "Bookworm"})
> client.search("name:Miles")
=> [{"hobby"=>"snowboarding"}, {"hobby"=>"couch-surfing"}]
```
