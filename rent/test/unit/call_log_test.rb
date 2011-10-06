require 'test_helper'

class CallLogTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert CallLog.new.valid?
  end
end
