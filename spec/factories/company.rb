FactoryGirl.define do
  factory :company do
    name do
      Faker::Company.name + ' ' + \
      Faker::Company.suffix + ' ' + \
      'from ' + Faker::StarWars.planet
    end
  end
end

