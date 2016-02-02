require 'waiting/waiter'
require 'waiting/version'

module Waiting
  # get the default wait interval
  # @return [Fixnum] the interval in seconds
  def self.default_interval
    @@default_interval ||= 5
  end

  # set the default wait interval
  # @param [Fixnum] interval the interval in seconds
  def self.default_interval=(interval)
    @@default_interval = interval
  end

  # get the default max attempts
  # @return [Fixnum] the default max attempts
  def self.default_max_attempts
    @@default_max_attempts ||= 60
  end

  # set the default max attempts
  # @param [Fixnum] max_attempts the default max attempts
  def self.default_max_attempts=(max_attempts)
    @@default_max_attempts = max_attempts
  end

  # wait for something, call #ok on the waiter to signal the wait is over
  # @param [Hash] opts the options to wait with.
  # @option opts [Fixnum] :interval polling interval in seconds for checking
  # @option opts [Fixnum] :max_attempts number of attempts before failing
  def self.wait(opts = {})
    interval = opts.fetch(:interval) { default_interval }
    max_attempts = opts.fetch(:max_attempts) { default_max_attempts }

    waiter = Waiter.new

    attempts = 0

    loop do
      fail "Timed out after #{interval * max_attempts}s" if attempts >= max_attempts
      yield(waiter)
      break if waiter.done?
      sleep interval
      attempts += 1
    end
  end
end
