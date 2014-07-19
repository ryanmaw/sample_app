require 'rails_helper'
require 'spec_helper'

# RSpec.describe "StaticPages", :type => :request do
#   describe "GET /static_pages" do
#     it "works! (now write some real specs)" do
#       get static_pages_index_path
#       expect(response.status).to be(200)
#     end
#   end
# end


describe "Static pages" do

	describe "Home page" do
		# TEST DESCRITPTION
		# Pass: The home page does contain the phrase 'Sample App'
		it "should have the content 'Sample App'" do
			visit '/static_pages/home'
			expect(page).to have_content('Sample App')
		end
		# TEST DESCRIPTION
		# Pass: <Title> must contain base title
		it "should have the base title" do
			visit '/static_pages/home'
			expect(page).to have_title("Ruby on Rails Tutorial Sample App")
		end
		# TEST DESCRIPTION
		# Pass: <title> must not contain "| home"
		it "should not have a custom page title" do
			visit '/static_pages/home'
			expect(page).not_to have_title('| Home')
		end
	end	

	describe "Help page" do	
		# TEST DESCRITPTION
		# Pass: The Help page does contain the phrase 'Help'
		it "should have the content 'Help" do
			visit '/static_pages/help'
			expect(page).to have_content('Help')
		end
		# TEST DESCRITPTION
		# Pass: <title div> must contain 'Help'
		it "should have the right title 'Help'" do
			visit '/static_pages/help'
			expect(page).to have_title("Help")
		end
	end

	describe "About page" do
		# TEST DESCRITPTION
		# Pass: The About page does contain the phrase 'About Us'
		it "should have the content 'About Us'" do
			visit '/static_pages/about'
			expect(page).to have_content('About Us')
		end
		# TEST DESCRITPTION
		# Pass: <title div> must contain 'About Us'
		it "should have the right title 'About Us'" do
			visit '/static_pages/about'
			expect(page).to have_title("About")
		end
	end
	describe "Contact Page" do
		# TEST DESCIPTION
		# Pass:
		it "should have the content 'Contact'" do
			visit '/static_pages/contact'
			expect(page).to have_content('Contact')
		end
		it "should have the title 'Contact'" do
			visit '/static_pages/contact'
			expect(page).to have_title('Contact')
		end
	end
end






















