# frozen_string_literal: true

require "active_support/core_ext/class/subclasses"

module ActiveSupport
  # This module provides an internal implementation to track descendants
  # which is faster than iterating through ObjectSpace.
  module DescendantsTracker
    DESCENDANTS_TRACKER_VERSION = "global_acc_simplified"

    @clear_disabled = false

    class << self
      def disable_clear! # :nodoc:
        @clear_disabled = true
      end
    end
  end
end
