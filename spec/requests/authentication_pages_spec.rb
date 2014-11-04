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

			describe "-> in the Users Controller " do

				describe "-> visiting the edit page" do
					before { visit edit_user_path(user) }
					it { should have_title('Sign In') }
					it { should have_selector("alert", "Please sign in.")}
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
	end
end

