FactoryGirl.define do
  factory :user do |user|
    user.email                 "fred.flintstone@bedrock.com"
    user.password              "secret"
    user.password_confirmation "secret"
    user.active                true
  end
end

