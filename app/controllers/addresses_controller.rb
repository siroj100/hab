class AddressesController < ApplicationController

  hobo_model_controller

  auto_actions :all, :except => [:index, :new]
  auto_actions_for :person, [:new, :create]

end
