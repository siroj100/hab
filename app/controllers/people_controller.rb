class PeopleController < ApplicationController

  hobo_model_controller

  auto_actions :all, :except => [:new]

  skip_before_filter :set_no_cache_headers, :only => [:index, :show]

  def index
    @people = find_or_paginate(Person, {})
    #puts "login as: #{current_user}, #{current_user.administrator?}, #{current_user.class}"
    unless current_user.administrator? || @people.length == 0  
      person = Person.last_updated_person
      expires_in 0.seconds
      fresh_when :etag=>person, :last_modified=>person.updated_at.utc, :public=>true
    end
    
  end

  def show
    @person = find_instance
    #puts "login as: #{current_user}, #{current_user.class}"
    if request.xhr?
      render :partial=>'addresses'
    elsif !current_user.administrator?
      expires_in 0.seconds
      fresh_when :etag=>@person, :last_modified=>@person.updated_at.utc, :public=>true
    end
  end

end
