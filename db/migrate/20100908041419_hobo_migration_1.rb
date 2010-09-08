class HoboMigration1 < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string   :street
      t.string   :zip
      t.string   :city
      t.string   :country
      t.datetime :created_at
      t.datetime :updated_at
      t.integer  :person_id
    end
    add_index :addresses, [:person_id]

    create_table :users do |t|
      t.string   :crypted_password, :limit => 40
      t.string   :salt, :limit => 40
      t.string   :remember_token
      t.datetime :remember_token_expires_at
      t.string   :name
      t.string   :email_address
      t.boolean  :administrator, :default => false
      t.datetime :created_at
      t.datetime :updated_at
      t.string   :state, :default => "active"
      t.datetime :key_timestamp
    end
    add_index :users, [:state]

    create_table :people do |t|
      t.string   :name
      t.string   :sex
      t.datetime :created_at
      t.datetime :updated_at
    end
  end

  def self.down
    drop_table :addresses
    drop_table :users
    drop_table :people
  end
end
