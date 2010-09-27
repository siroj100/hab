class Person < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    name :string
    sex  :string
    sex enum_string('', :male, :female)
    timestamps
  end

  
  has_many :addresses, :dependent => :destroy

  # --- Permissions --- #

  def create_permitted?
    acting_user.administrator?
  end

  def update_permitted?
    acting_user.administrator?
  end

  def destroy_permitted?
    acting_user.administrator?
  end

  def view_permitted?(field)
    true
  end


  # --- Custom finder --- #

  def self.last_updated_person
    people = find :all, :order=>'updated_at DESC'
    unless people.length == 0 then return people[0] end
  end

end
