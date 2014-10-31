require 'rails_helper'
require 'spec_helper'


describe "Authentication" do
	
	subject { page }

	describe "signin page" do
		before { visit signin_path }

		it { should have_content( 'Sign In' ) }

		#### INVALID UNIT TESTING ####

		describe "With INVALID information" do
			before { click_button "Sign In"}

			it { should have_title( 'Sign In' ) }
			it { should have_selector('div.alert.alert-danger', text: 'Invalid') }

			describe "after visiting another page" do
			  before { click_link "Home" }
			  it { should_not have_selector('div.alert.alert-danger') }
			end
		end

		#### VALID UNIT TESTING ####

		describe "With VALID information" do
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

end

