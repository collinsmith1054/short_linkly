FactoryBot.define do
  factory :short_link do
    sequence :long_link do |n|
      "https://www.google.com/#{n}"
    end
  end
end
