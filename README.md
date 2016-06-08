[![Build Status](https://travis-ci.org/meringu/waiting.svg?branch=master)](https://travis-ci.org/meringu/waiting)

# Waiting

Waits so you don't have to!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'waiting'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install waiting

## Usage

```ruby
require 'waiting'

# optional
Waiting.default_max_attempts = max_attempts # defaults to 60
Waiting.default_interval = interval # seconds, defaults to 5

# will poll every interval max_attempts times until something returns true
Waiting.wait do |waiter|
  waiter.done if something
end

# You can also specify the max_attempts and interval this way
Waiting.wait(interval: interval, max_attempts: max_attempts) do |waiter|
  waiter.done if something
end

# You can do exponential backoff
# for example, exp_base of 2 and an interval of 1 second,
# will wait for: 1,2,4,8...
Waiting.wait(exp_base: 2) do |waiter|
  waiter.done if something
end

# or specify it as a default
Waiting.default_exp_base = exp_base # exponential backoff base, defaults to 1
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/meringu/waiting.
