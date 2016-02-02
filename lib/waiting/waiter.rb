module Waiting
  class Waiter
    # Waiter is in waiting state to start with
    def initialize
      @done = false
    end

    # Mark the waiter as done
    def done
      @done = true
    end

    # Is the waiter done?
    # @return [Boolean] if the waiter is done
    def done?
      @done
    end
  end
end
