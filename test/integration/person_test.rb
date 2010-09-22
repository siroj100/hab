require File.dirname(__FILE__) + '/../test_helper'

class PersonTest < ActionController::IntegrationTest 
  context 'A person' do
    setup do
      @person = Factory(:person)
    end
    
    should 'be visible on the web and clickable' do
      visit '/people'
      assert_contain @person.name
      click_link @person.name
      assert_equal 200, status
    end
  end
end

