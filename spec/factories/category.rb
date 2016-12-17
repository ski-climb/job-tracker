FactoryGirl.define do
  factory :category do
    title do
      Faker::StarWars.specie
    end
  end
end
