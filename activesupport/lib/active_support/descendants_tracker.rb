# frozen_string_literal: true

require "weakref"
require "active_support/ruby_features"

module ActiveSupport
  # This module provides an internal implementation to track descendants
  # which is faster than iterating through ObjectSpace.
  module DescendantsTracker
    class << self
      def direct_descendants(klass)
        ActiveSupport::Deprecation.warn(<<~MSG)
          ActiveSupport::DescendantsTracker.direct_descendants is deprecated and will be removed in Rails 7.1.
          Use ActiveSupport::DescendantsTracker.subclasses instead.
        MSG
        subclasses(klass)
      end
    end

    @clear_disabled = false

    class << self
      def disable_clear! # :nodoc:
        unless @clear_disabled
          @clear_disabled = true
        end
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
      subclasses.concat(subclasses.flat_map(&:descendants))
    end

    def direct_descendants
      ActiveSupport::Deprecation.warn(<<~MSG)
          ActiveSupport::DescendantsTracker#direct_descendants is deprecated and will be removed in Rails 7.1.
          Use #subclasses instead.
        MSG
      subclasses
    end
  end
end
