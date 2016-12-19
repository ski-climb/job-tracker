FactoryGirl.define do
  factory :job do
    title { Faker::Name.title }
    description { Faker::ChuckNorris.fact }
    level_of_interest { Faker::Number.between(50, 100) }
    city { Faker::GameOfThrones.city }
    company
    category
  end
end
