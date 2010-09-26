require 'factory_girl'

Factory.define :admin, :class=> User do |u|
  u.name 'admin'
  u.email_address 'siroj100@gmail.com'
  u.password 'ganteng'
  u.administrator true
end

Factory.define :user do |u|
  u.name 'user'
  u.email_address 'siroj100@yahoo.com'
  u.password 'ganteng'
  u.administrator false
end

