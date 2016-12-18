FactoryGirl.define do
  factory :comment do
    content Faker::StarWars.quote
    job
  end
end
