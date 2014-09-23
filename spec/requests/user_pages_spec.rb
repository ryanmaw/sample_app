require 'rails_helper'
require 'spec_helper'
# RSpec.describe "UserPages", :type => :request do
#   describe "GET /user_pages" do
#     it "works! (now write some real specs)" do
#       get user_pages_index_path
#       expect(response.status).to be(200)
#     end
#   end
# end
describe "User Pages" do
	subject { page }

	describe "signup page" do
		before { visit signup_path }
		it { should have_title(full_title("Sign Up")) }
		it { should have_content("Sign up") }
	end

	describe "signup" do
		before { visit signup_path }
		
		let(:submit) { "Create my account" }

		describe "with invalid information" do
			it "should not create user" do
				expect { click_button submit }.not_to change(User,:count)
			end
		end

		describe "with valid information" do
			before do
				fill_in "Name",				with: "Example User"
				fill_in "Email",			with: "user@example.com"
				fill_in "Password",			with: "foobar"
				fill_in "Confirm Password",		with: "foobar"
			end

			it "should create a user" do
				expect { click_button submit }.to change(User,:count).by(1)
			end

		end
	end



end
