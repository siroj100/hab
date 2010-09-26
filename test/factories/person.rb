require 'factory_girl'

Factory.define :person do |p|
  p.name 'Sirajuddin Maizir'
  p.sex 'male'
end

Factory.define :ning, :class=> Person do |p|
  p.name 'Suwastiningsih'
  p.sex 'female'
end
