require 'factory_girl'

Factory.define :address do |a|
  a.street 'Jl. K.H. Ahmad Dahlan VI no 21F'
  a.zip '16425'
  a.city 'Depok'
  a.country 'ID'
  a.association :person
end
