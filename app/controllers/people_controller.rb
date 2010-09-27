class PeopleController < ApplicationController

  hobo_model_controller

  auto_actions :all, :except => [:new]

  def index
    @people = find_or_paginate(Person, {})
    unless @people.length == 0
      person = Person.last_updated_person
      fresh_when :etag=>person, :last_modified=>person.updated_at.utc, :public=>true
    end
    
  end

  def show
    @person = find_instance
    fresh_when :etag=>@person, :last_modified=>@person.updated_at.utc, :public=>true
  end

end
