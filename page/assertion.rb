module Assertion
  class AssertionError < StandardError; end;
  def assert(message, asserted = true)
    if not(asserted) || (block_given? && not(yield))
      raise AssertionError.new(message)
    end
  end
end