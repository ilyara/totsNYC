require 'test_helper'

class ManagerTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Manager.new.valid?
  end
end
