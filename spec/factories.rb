

# Factory.define :user do |f|
#   f.sequence(:email) { |n| "chai#{n}example.com" }
#   f.password "secret"
# end

FactoryGirl.define do
  factory :user do
  email = (('a'..'z').to_a + (0..9).to_a).shuffle[0..6].join
  password = url_short = (('a'..'z').to_a + (0..9).to_a).shuffle[0..10].join
    email "#{email}@chai.com"
    password "#{password}"
  end
end

# FactoryGirl.define do
#   factory :shop do
#   shop = Shop.new(shop_params)
#   end
# end

