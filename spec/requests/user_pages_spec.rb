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
				expect { click_button submit }.not_to change(User, :count)
			end
			describe "with invalid information" do
				before { click_button submit }

				it { should have_title('Sign Up') }
				it { should have_content('error') }
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
				expect { click_button submit }.to change(User, :count).by(1)
			end

			describe "after saving the user" do
				before { click_button submit }
				let(:user) { User.find_by(email: 'user@example.com') }

				it { should have_title(user.name) }
				it { should have_selector('div.alert.alert-success', text: 'succesfully registered') }
				it { should have_link('Sign Out') }
			end

		end
	end

	describe "edit" do
		#Factory girl a user
		let(:user) { FactoryGirl.create(:user) }
		before { visit edit_user_path(user) }

		describe "page" do
			it { should have_title("Edit User") }
			#it { should have_link("change", href: 'http://gravatar.com/emails') }
			it { should have_selector('h1', text: "Update Your Profile") }
		end

		describe "with invalid information" do
			before { click_button 'Save Changes' }
			it { should have_content('Error') }
		end



	end



end
