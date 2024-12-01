# frozen_string_literal: true

require "active_support/ruby_features"

class Class
  # Returns an array with all classes that are < than its receiver.
  #
  #   class C; end
  #   C.descendants # => []
  #
  #   class B < C; end
  #   C.descendants # => [B]
  #
  #   class A < B; end
  #   C.descendants # => [B, A]
  #
  #   class D < C; end
  #   C.descendants # => [B, A, D]
  def descendants
    descendants_of self
  end

  def descendants_of(klass)
    arr = []
    accumulate_descendants(klass, arr)
    arr
  end

  def accumulate_descendants(klass, acc)
    klass.subclasses.each do |direct_descendant|
      acc << direct_descendant
      accumulate_descendants(direct_descendant, acc)
    end
  end
end
