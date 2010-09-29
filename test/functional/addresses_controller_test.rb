require File.dirname(__FILE__) + '/../test_helper'

class AddressesControllerTest < ActionController::TestCase
  def setup
    @address = Factory(:address_wo_person)
    @person = Factory(:person)
    @admin = Factory(:admin)
    @user = Factory(:user)
  end

  def test_address_creatable_by_admin
    login_as(@admin)
    get :create_for_person, :person_id => @person.id
    assert_tag :tag=>'form'
    post :create, :address => @address.attributes
    assert_response :redirect
  end

  def test_address_not_creatable_guest
    get :create_for_person, :person_id => @person.id
    assert_no_tag :tag=>'form'
    post :create, :address => @address.attributes
    assert_response :forbidden
  end

  def test_address_not_creatable_guest
    login_as(@user)
    get :create_for_person, :person_id => @person.id
    assert_no_tag :tag=>'form'
    post :create, :address => @address.attributes
    assert_response :forbidden
  end

end
