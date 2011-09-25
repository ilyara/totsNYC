require 'test_helper'

class TestieTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Testie.new.valid?
  end
end
