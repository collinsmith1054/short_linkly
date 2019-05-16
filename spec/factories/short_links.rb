FactoryBot.define do
  factory :short_link do
    long_link { 'https://www.google.com' }
  end
end
