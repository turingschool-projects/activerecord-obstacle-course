FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@gmail.com" }
    sequence(:name) { |n| "User Name #{n}" }
  end
end
