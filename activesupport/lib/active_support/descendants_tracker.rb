# frozen_string_literal: true

require "weakref"
require "active_support/ruby_features"

module ActiveSupport
  # This module provides an internal implementation to track descendants
  # which is faster than iterating through ObjectSpace.
  module DescendantsTracker
    DESCENDANTS_TRACKER_VERSION = "subclasses_true"

    @clear_disabled = false

    class << self
      def disable_clear! # :nodoc:
        @clear_disabled = true
      end

      def subclasses(klass)
        klass.subclasses
      end

      def descendants(klass)
        klass.descendants
      end

      def clear(classes) # :nodoc:
        raise "intentionally not implemented"
      end

      def native? # :nodoc:
        true
      end
    end

    def descendants
      subclasses(true)
    end
  end
end
