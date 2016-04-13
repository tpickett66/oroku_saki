# OrokuSaki
[![Build Status](https://travis-ci.org/tpickett66/oroku_saki.svg?branch=master)](https://travis-ci.org/tpickett66/oroku_saki)
[![Gem Version](https://badge.fury.io/rb/oroku_saki.svg)](https://badge.fury.io/rb/oroku_saki)

OrokuSaki, a.k.a. Shredder, is the destroyer of strings and attacker's worst
nightmare!

But seriously, this is a collection of small tools for helping your secrets in
crypto applications stay secret.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'oroku_saki'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install oroku_saki

## Usage

Immediately zeroing out the memory location of a string you want to protect:

```ruby
my_secret = 'super sekret value!!!'
OrokuSaki.shred!(my_secret) # => nil
puts my_secret # => "\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000"

second_secret = 'another sekret'
# String#shred! delegates to OrokuSaki.shred!
second_secret.shred! # => "\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000\u0000"
```

Setting a string to be shredded before garbage collection via a finalizer:

```ruby
my_secret = 'super sekret value!!!'
OrokuSaki.shred_later(my_secret) # => nil
puts my_secret # => "super sekret value!!!"

second_secret = 'another sekret'
second_scret.shred_later
```

Comparing Strings in constant time (nearly as fast as `==` for small inputs):

```ruby
hmac = '16b9b8ae8e164768d0505bcb16269efb35804643dd351084b3c6ebbc6f7db2c8'
other_hmac = '16b9b8ae8e164768d0505bcb16269efb35804643dd351084b3c6ebbc6f7db2c8'
OrokuSaki.secure_compare(hmac, other_hmac) #=> true
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tpickett66/oroku_saki. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

