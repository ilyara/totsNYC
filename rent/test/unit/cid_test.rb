require 'test_helper'

class CidTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Cid.new.valid?
  end
end
