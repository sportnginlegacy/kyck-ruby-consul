# Consul

Ruby client gem to interact with [consul.io](http://consul.io) agents.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ruby-consul', git: 'git@github.com:kyck/ruby-consul'
```

And then execute:

    $ bundle

## Usage

```ruby
require 'consul'

client    = Consul.client
services  = client.service 'web'                #=> [Array of service objects]
addresses = services.map { |s| s.node.address } #=> [Array of ip addresses/host names]
```

This assumes the defaults that there is an agent running on the localhost, listening on port 8500. To customize:

```ruby
require 'consul'

Consul.configure |config|
  config.address = "192.168.1.23"
  config.port    = 8501
end

client = Consul.client
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/ruby-consul/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
