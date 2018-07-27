FactoryBot.define do
  factory :contact do
    email { Faker::Lorem.word }
    name "ashok"
    title "RoR Developer"
    created_by { Faker::Number.number(10) }
  end

end