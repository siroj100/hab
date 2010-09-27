class Address < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    street  :string
    zip     :string
    city    :string
    country :string
    country enum_string(*Carmen::country_codes)
    timestamps
  end


  belongs_to :person, :touch => true
  validates_presence_of :person
  validates_inclusion_of :country, :in => Carmen::country_codes

  def to_s
    street
  end

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

end
