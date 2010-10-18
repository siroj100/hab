class PeopleController < ApplicationController

  hobo_model_controller

  auto_actions :all, :except => [:new]

  skip_before_filter :set_no_cache_headers, :only => [:index, :show]

  def index
    @people = find_or_paginate(Person, {})
    #puts "login as: #{current_user}, #{current_user.administrator?}, #{current_user.class}"
    last_updated_at = 0
    unless @people.length == 0  
      last_updated_at = Person.maximum(:updated_at).utc
    end
    action_tag = "#{current_user}/#{last_updated_at}"
    expires_in 0.seconds
    fresh_when :etag=>action_tag, :last_modified=>last_updated_at, :public=>true
  end

  def show
    @person = find_instance
    #puts "login as: #{current_user}, #{current_user.class}"
    if request.xhr?
      render :partial=>'addresses'
    else 
      action_tag = "#{current_user}/#{@person.updated_at.utc}"
      expires_in 0.seconds
      fresh_when :etag=>action_tag, :last_modified=>@person.updated_at.utc, :public=>true
    end
  end

end
