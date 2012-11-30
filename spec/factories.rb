

# Factory.define :user do |f|
#   f.sequence(:email) { |n| "chai#{n}example.com" }
#   f.password "secret"
# end

FactoryGirl.define do
  factory :user do
    email "AAAAAAAHHHHHHhhhh@chai.com"
    password "secret"
    # password_confirmation "secret"
  end
end

# FactoryGirl.create :user