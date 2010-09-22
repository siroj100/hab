require File.dirname(__FILE__) + '/../test_helper'

class AddressTest < ActionController::IntegrationTest 
  context 'An address of a person' do
    setup do
      @address = Factory(:address)
    end
    
    should 'be visible on person page' do
      visit '/people'
      click_link @address.person.name
      assert_contain @address.street
    end

    should 'be able to see the details (street, zip, city, country code)' do
      visit '/people'
      click_link @address.person.name
      click_link @address.street
      assert_equal 200, status
      assert_contain @address.street
      assert_contain @address.zip
      assert_contain @address.city
      assert_contain @address.country
    end

  end
end

