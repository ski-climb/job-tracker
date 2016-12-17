FactoryGirl.define do
  factory :category do
    title do 
      Faker::StarWars.specie + \
      Faker::StarWars.planet + " " + \
      Faker::Number.between(1, 100).to_s
    end
  end
end
