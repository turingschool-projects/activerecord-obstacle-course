FactoryBot.define do
  factory :item, class: Item do
    sequence(:name) { |n| "Thing #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    sequence(:image_url) { |n| "https://picsum.photos/200/300?image=#{n}" }
  end
end
