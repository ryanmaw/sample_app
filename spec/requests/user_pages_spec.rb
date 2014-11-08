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
describe "User Pages " do
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

	describe "-> Edit" do
		#Factory girl a user
		let(:user) { FactoryGirl.create(:user) }

		before do
		  sign_in user
		  visit edit_user_path(user)
		end

		describe "-> page" do
			it { should have_selector('h1',    text: "Update Your Profile") }
	        it { should have_title("Edit User Information") }
		    #it { should have_link('change', href: 'http://gravatar.com/emails') }
		end

		describe "-> with invalid information" do
			before { click_button 'Save Changes' }
			it { should have_content('Wow there') }
		end

		describe "->with Valid Information" do
			let(:new_name) { "New Name" }
			let(:new_email) { "new@example.com" }
			before do
				fill_in "Name",				with: new_name
				fill_in "Email",			with: new_email
				fill_in "Password", 		with: user.password
				fill_in "Confirm Password", with: user.password
				click_button "Save Changes"
			end
			it { should have_title(new_name) }
		    it { should have_selector('div.alert.alert-success') }
		    it { should have_link('Sign Out', href: signout_path) }
		    specify { user.reload.name.should  == new_name }
            specify { user.reload.email.should == new_email }
		end



	end

	describe "-> Index " do
		# create three users
		# sign in one
		# visit page
		let(:user) { FactoryGirl.create(:user) }

		before(:each) do
			sign_in user
			visit users_path
		end

		# describe page
		# should have correct title
		# should have correct h1 
		# should have a li tag for each user name
		it { should have_title("All Users") }
		it { should have_selector("h1", text: "All Users") }

		describe "pagination" do

			before(:all) { 30.times { FactoryGirl.create(:user) } }
			after(:all) { User.delete_all }

			it { should have_selector('div.pagination') }

			it  "should list each user"  do
				User.paginate(page: 1).each do |user|
					page.should have_selector('li', text: user.name)
				end
			end
		end
	end
end
