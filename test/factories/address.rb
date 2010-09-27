require 'factory_girl'

Factory.define :address do |a|
  a.street 'Jl. K.H. Ahmad Dahlan VI no 21F'
  a.zip '16425'
  a.city 'Depok'
  a.country 'ID'
  a.association :person
end

Factory.define :address_wo_person, :class => Address, :default_strategy => :build do |a|
  a.street 'Jl. K.H. Ahmad Dahlan VI no 21F'
  a.zip '16425'
  a.city 'Depok'
  a.country 'ID'
end

Factory.define :address_w_invalid_country_code, :class => Address, :default_strategy => :build  do |a|
  a.street 'Jl. K.H. Ahmad Dahlan VI no 21F'
  a.zip '16425'
  a.city ''
  a.country 'ZZ'
  a.association :person
end


