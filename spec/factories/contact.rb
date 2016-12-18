FactoryGirl.define do
  factory :contact do
    name { Faker::GameOfThrones.character }
    position { Faker::Name.title }
    email { Faker::Internet.email }
    company
  end
end
