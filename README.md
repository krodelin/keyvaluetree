# keyvaluetree

keyvalutree provides an wrapper around a flat KeyValueStore which emulates an hierachical store (i.e. nested Hashes).

## Installation

Add this line to your application's Gemfile:

    gem 'keyvaluetree'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install keyvaluetree

## Usage

### Simple

    config = KeyValueTree::Hash.new()

    config.server.name = 'localhost'
    config.server['port'] = '123'

    config.server['name'] => 'localhost'
    config.server.port = '123'

### Using explicit MemoryStore

    config = KeyValueTree::Hash.new(KeyValueTree::MemoryStore.new())

    config.server.name = 'localhost'
    config.server['port'] = '123'

    config.server['name'] => 'localhost'
    config.server.port = '123'

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
