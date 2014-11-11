# This is the way to hard code a factory

# FactoryGirl.define do
#     factory :user do
#     	name "test user"
#         email "test@test.com"
#         password "foobar"
#         password_confirmation "foobar"
#     end
# end
 
 # What if we want to create a squence of users
 # Factories have a sequence method to handle such a need

 FactoryGirl.define do
 	factory :user do
 		sequence(:name) { |n| "person #{n}" }
 		sequence(:email) { |n| "person_#{n}@example.com"}
 		password "foobar"
 		password_confirmation "foobar"

 		factory :admin do
 			admin true
 		end
 	end
 end