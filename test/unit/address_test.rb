require File.dirname(__FILE__) + '/../test_helper'

class AddressTest < ActiveSupport::TestCase

  def test_valid_address
    address = Factory(:address)
    assert_valid address
  end

  def test_address_wo_person
    address = Factory(:address_wo_person)
    assert !address.valid?
    assert !address.errors.invalid?(:country)
    assert address.errors.invalid?(:person)
  end

  def test_address_w_invalid_country_code
    address = Factory(:address_w_invalid_country_code)
    assert !address.valid?
    assert address.errors.invalid?(:country)
    assert !address.errors.invalid?(:person)
  end


end
