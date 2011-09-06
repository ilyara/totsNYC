require 'test_helper'

class AvatarTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Avatar.new.valid?
  end
end
