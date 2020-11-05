FactoryBot.define do
  factory :post do
    content { Faker::Lorem.sentence}
    title {Faker::Lorem.sentence}
    association :user
  end

  after(:build) do |post|
    post.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
  end
end
