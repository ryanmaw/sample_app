FactoryGirl.define do
    factory :user do
    	name "test user"
        email "test@test.com"
        password "foobar"
        password_confirmation "foobar"
    end
end