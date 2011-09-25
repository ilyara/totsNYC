require 'test_helper'

class GadflyTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Gadfly.new.valid?
  end
end
