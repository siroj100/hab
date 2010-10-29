require File.dirname(__FILE__) + '/acceptance_helper'

feature "Feature name", %q{
  In order to ...
  As a ...
  I want to ...
} do

  before do
  end

  background do
    logger.info('background')
    Address.delete_all
    Person.delete_all
    User.delete_all

    @address = Factory(:address)
    @admin = Factory(:admin)
    @user = Factory(:user)
  end

  scenario "A person should be visible on the web and clickable" do
    #logger.info('scenario #00')
    p = Person.find(@address.person.id)
    visit '/people'
    page.should have_content(@address.person.name)
    click_link @address.person.name
    page.should have_content(@address.person.name)
    #response.should be_success
    #assert_equal 200, status
  end

=begin
  scenario "An address of a person should be visible on the person page" do
    #logger.info('scenario #01')
    visit '/people'
    click_link @address.person.name
    page.should have_content(@address.street)
  end
=end

  scenario "Address details of a person should be visible" do
    #logger.info('scenario #02')
    visit '/people'
    click_link @address.person.name
    click_link @address.street
    page.should have_content(@address.street)
    page.should have_content(@address.zip)
    page.should have_content(@address.city)
    page.should have_content(@address.country)
  end

  scenario "An address of a person should be editable by an admin" do
    #logger.info('scenario #03')
    visit '/login'
    fill_in 'login', :with => @admin.email_address
    fill_in 'password', :with => @admin.password
    click_button 'Log in'
    visit '/people'
    click_link @address.person.name
    click_link @address.street
    page.should have_content('Edit Address')
    #visit '/logout'
  end

  scenario "An address of a person be not editable by guest" do
    #logger.info('scenario #04')
    visit '/people'
    #save_and_open_page
    click_link @address.person.name
    click_link @address.street
    page.should_not have_content('Edit Address')
  end
  
  scenario "An address of a person be not editable by regular user" do
    #logger.info('scenario #05')
    visit '/login'
    #save_and_open_page
    fill_in 'login', :with => @user.email_address
    fill_in 'password', :with => @user.password
    click_button 'Log in'
    #assert_equal 200, status
    #assert_equal '/', path
    visit '/people'
    click_link @address.person.name
    click_link @address.street
    page.should_not have_content('Edit Address')
    #visit '/logout'
    #save_and_open_page
  end

  scenario "Changes to an address should be visible after being edited" do
    #logger.info('scenario #06')
    visit '/people'
    #save_and_open_page
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
