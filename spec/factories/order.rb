FactoryBot.define do
  factory :order, class: Order do
    user
    sequence(:amount) { |n| "#{n}" }
  end
end
