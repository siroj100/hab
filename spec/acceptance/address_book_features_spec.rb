require File.dirname(__FILE__) + '/acceptance_helper'

feature "Address Book features" do

  background do
    @address = Factory(:address)
    @admin = Factory(:admin)
    @user = Factory(:user)
  end

  scenario "A person should be visible on the web and clickable" do
    p = Person.find(@address.person.id)
    visit '/people'
    page.should have_content(@address.person.name)
    click_link @address.person.name
    page.should have_content(@address.person.name)
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
  end

  scenario "An address of a person be not editable by guest" do
    visit '/people'
    click_link @address.person.name
    click_link @address.street
    page.should_not have_content('Edit Address')
  end
  
  scenario "An address of a person be not editable by regular user" do
    visit '/login'
    fill_in 'login', :with => @user.email_address
    fill_in 'password', :with => @user.password
    click_button 'Log in'
    visit '/people'
    click_link @address.person.name
    click_link @address.street
    page.should_not have_content('Edit Address')
  end

  scenario "Changes to an address should be visible after being edited" do
    visit '/people'
    click_link @address.person.name
    page.should have_content(@address.street)

    visit '/login'
    fill_in 'login', :with => @admin.email_address
    fill_in 'password', :with => @admin.password
    click_button 'Log in'

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
