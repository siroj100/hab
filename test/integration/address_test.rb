require File.dirname(__FILE__) + '/../test_helper'

class AddressTest < ActionController::IntegrationTest 
  context 'An address of a person' do
    setup do
      @address = Factory(:address)
      @admin = Factory(:admin)
      @user = Factory(:user)
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

    should 'be editable by an admin' do
      visit '/login'
      fill_in 'login', :with => @admin.email_address
      fill_in 'password', :with => @admin.password
      click_button 'Log in'
      assert_equal 200, status
      assert_equal '/', path
      visit '/people'
      click_link @address.person.name
      click_link @address.street
      assert_contain 'Edit Address'
    end

    should 'be not editable by guest' do
      visit '/people'
      click_link @address.person.name
      click_link @address.street
      assert_not_contain 'Edit Address'
    end

    should 'be not editable by regular user' do
      visit '/login'
      fill_in 'login', :with => @user.email_address
      fill_in 'password', :with => @user.password
      click_button 'Log in'
      assert_equal 200, status
      assert_equal '/', path
      visit '/people'
      click_link @address.person.name
      click_link @address.street
      assert_not_contain 'Edit Address'
    end

    should 'changes be visible after being edited' do
      visit '/people'
      click_link @address.person.name
      assert_contain @address.street

      visit '/login'
      fill_in 'login', :with => @admin.email_address
      fill_in 'password', :with => @admin.password
      click_button 'Log in'
      assert_equal 200, status
      assert_equal '/', path

      visit '/people'
      click_link @address.person.name
      click_link @address.street
      click_link 'Edit Address'
      fill_in 'address[street]', :with => 'Test Address'
      click_button 'Save'
      visit '/logout'

      visit '/people'
      click_link @address.person.name
      assert_not_contain @address.street
      assert_contain 'Test Address'
    end

  end
end

