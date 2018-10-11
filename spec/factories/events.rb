# spec/factories/events.rb

FactoryBot.define do
  factory :event do
    title       { Faker::LordOfTheRings.character }
    url         { Faker::Internet.url('https://gorki.de/de') }
    start_date  { Faker::Date.between(2.days.ago, Date.today) }
    web_source  { 'Gorki' }
  end
end