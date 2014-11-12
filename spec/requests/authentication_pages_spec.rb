require 'rails_helper'
require 'spec_helper'


describe "Authentication " do
	
	subject { page }

	describe "-> signin page " do
		before { visit signin_path }

		it { should have_content( 'Sign In' ) }

		#### INVALID UNIT TESTING ####

		describe "-> With INVALID information" do
			before { click_button "Sign In"}

			it { should have_title( 'Sign In' ) }
			it { should have_selector('div.alert.alert-danger', text: 'Invalid') }

			describe "-> after visiting another page" do
			  before { click_link "Home" }
			  it { should_not have_selector('div.alert.alert-danger') }
			end
		end

		#### VALID UNIT TESTING ####

		describe "-> With VALID information" do
			let(:user) { FactoryGirl.create(:user) }

			# refractored... Helper method in support/utlities
			before { sign_in(user) }

			it { should have_title(user.name) }
			it { should have_link('Users',			href: users_path) }
			it { should have_link('Profile',		href: user_path(user)) }
			it { should have_link('Sign Out',		href: signout_path) }
			it { should_not have_link('Sign In',	href: signin_path) }
			it { should have_link('Settings', 		href: edit_user_path(user))}

			describe "followed by signout" do
				before { click_link "Sign Out" }
				it { should have_link('Sign In') }
			end
		end
	end
	describe "Authorization " do
		describe "-> for non-signed in users " do
			let(:user) { FactoryGirl.create(:user) }

			describe "-> visiting the home page" do
				before { visit root_url }

				it { should_not have_link("Profile") }
				it { should_not have_link("Settings") }

			end

			# To test for such “friendly forwarding”, we first visit the user edit page, which redirects to the signin page.
			# We then enter valid signin information and click the “Sign in” button. 
			# The resulting page, which by default is the user’s profile, should in this case be the “Edit user” page.

			describe "-> Visiting a Protected Page " do
				before do
					visit edit_user_path(user)
					fill_in("Email",			with: user.email)
					fill_in("Password",		with: user.password)
					click_button "Sign In"
				end
				describe "-> After Signing In" do
					it "should render the edit page" do
						page.should have_title("Edit User Information")
					end
				end
			end

			describe "-> in the Users Controller " do

				describe "-> visiting the edit page" do
					before { visit edit_user_path(user) }
					it { should have_title('Sign In') }
					it { should have_selector('div.alert', text: "Please sign in.") }
				end

				describe "-> visiting the user index page " do
					before { visit users_path }
					it { should have_title('Sign In') }
				end

				describe "-> submitting to the update action" do

					# Capybara's Visit method can be replicated by using the appropriate HTTP request directly.
					# This is another way to access a controller action 
					before { put user_path(user) }
					#This is necessary because there is no way for a browser to visit the update action directly—it 
					#can only get there indirectly by submitting the edit form—so Capybara can’t do it either. 
					#But visiting the edit page only tests the authorization for the edit action, not for update. 
					#As a result, the only way to test the proper authorization for the update action itself is 
					#to issue a direct request.
					#before { visit user_path(user ) }

					# When we issue an direct HTTP call then we get access to the server response.  
					specify { response.should redirect_to(signin_path) }
				end
			end
		end

		describe "-> As wrong user " do
			# The :user tries to access the :wrong_user page path and should get redirected to the root.

			# Create factory right user
			let(:user) { FactoryGirl.create(:user) }
			let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@email.com") }
			before { sign_in(user) }
			# Create factory wrong user
			# Signin wrong user
			describe "-> Visiting User#Edit page" do
				before { visit edit_user_path(wrong_user) }
				it { should_not have_title(full_title("Edit User Information")) }				
			end

			# submit a put request to User#edit and check that we redirect to the root_url
			describe "-> submitting a PUT request to the User#update action" do
				before { put user_path(wrong_user) }
				specify { response.should redirect_to(root_url) }
			end


		end

		describe "-> As non - admin user" do
			let(:user) { FactoryGirl.create(:user) }
			let(:non_admin) { FactoryGirl.create(:user) }
			before { sign_in non_admin }

			describe "Non admin submiting a delete request via Users#destroy" do
				before { delete user_path(user) }
				specify { response.should redirect_to(root_url) }

			end
		end

		describe "For signed in user " do
			# test that signed in user are redirected to the root_url when they access create or new
			let(:user) { FactoryGirl.create(:user) }
			before { sign_in user }

			# Trying to signup when already signed in
			describe "Trying to access Users#New" do
				before { get signup_path }
				specify { response.should redirect_to(root_url) }
			end

			# Trying to signin while already signed in
			describe "Trying to access Sessions#New" do
				before { get signin_path }
				specify { response.should redirect_to(root_url) }
			end




		end

	end
end














