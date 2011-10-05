require 'test_helper'

class SelectionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Selection.new.valid?
  end
end
