require File.dirname(__FILE__) + '/acceptance_helper'

feature "Feature name", %q{
  In order to ...
  As a ...
  I want to ...
} do

  background do
    @address = Factory(:address)
    @admin = Factory(:admin)
    @user = Factory(:user)
    #puts "counting: #{@address.id}, #{@person.id}, #{@address.person.id}"
  end
 
  scenario "A person should be visible on the web and clickable" do
    visit '/people'
    page.should have_content(@address.person.name)
    click_link @address.person.name
    page.should have_content(@address.person.name)
    #response.should be_success
    #assert_equal 200, status
    #true.should == true
  end

  scenario "An address of a person should be visible on the person page" do
    visit '/people'
    click_link @address.person.name
    page.should have_content(@address.street)
  end

  scenario "Address details of a person should be visible" do
    visit '/people'
    click_link @address.person.name
    click_link @address.street
    page.should have_content(@address.street)
    page.should have_content(@address.zip)
    page.should have_content(@address.city)
    page.should have_content(@address.country)
  end

  scenario "An address of a person should be editable by an admin" do
    visit '/login'
    fill_in 'login', :with => @admin.email_address
    fill_in 'password', :with => @admin.password
    click_button 'Log in'
    visit '/people'
    click_link @address.person.name
    click_link @address.street
    page.should have_content('Edit Address')
    visit '/logout'
  end

  scenario "An address of a person be not editable by guest" do
    #save_and_open_page
    visit '/people'
    click_link @address.person.name
    click_link @address.street
    page.should_not have_content('Edit Address')
  end
  
  scenario "An address of a person be not editable by regular user" do
    #save_and_open_page
    visit '/login'
    fill_in 'login', :with => @user.email_address
    fill_in 'password', :with => @user.password
    click_button 'Log in'
    #assert_equal 200, status
    #assert_equal '/', path
    visit '/people'
    click_link @address.person.name
    click_link @address.street
    page.should_not have_content('Edit Address')
    visit '/logout'
  end

  scenario "Changes to an address should be visible after being edited" do
    #save_and_open_page
    visit '/people'
    click_link @address.person.name
    page.should have_content(@address.street)

    visit '/login'
    fill_in 'login', :with => @admin.email_address
    fill_in 'password', :with => @admin.password
    click_button 'Log in'
    #assert_equal 200, status
    #assert_equal '/', path

    visit '/people'
    click_link @address.person.name
    click_link @address.street
    click_link 'Edit Address'
    fill_in 'address[street]', :with => 'Test Address'
    click_button 'Save'
    visit '/logout'

    visit '/people'
    click_link @address.person.name
    page.should_not have_content(@address.street)
    page.should have_content('Test Address')
  end
  
end
