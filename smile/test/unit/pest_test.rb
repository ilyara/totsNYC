require 'test_helper'

class PestTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Pest.new.valid?
  end
end
