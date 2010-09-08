class Address < ActiveRecord::Base

  hobo_model # Don't put anything above this

  fields do
    street  :string
    zip     :string
    city    :string
    country :string
    timestamps
  end


  belongs_to :person

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
