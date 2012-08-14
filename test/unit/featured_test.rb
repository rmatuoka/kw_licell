require 'test_helper'

class FeaturedTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Featured.new.valid?
  end
end
