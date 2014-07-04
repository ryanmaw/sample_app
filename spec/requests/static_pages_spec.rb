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
	# TEST DESCRITPTION
	# Pass: The home page does contain the phrase 'Sample App'
	describe "Home page" do
		it "should have the content 'Sample App'" do
			visit '/static_pages/home'
			expect(page).to have_content('Sample App')
		end
	end	
	
	# TEST DESCRITPTION
	# Pass: The Help page does contain the phrase 'Help'
	describe "Help page" do
		it "should have the content 'Help" do
			visit '/static_pages/help'
			expect(page).to have_content('Help')
		end
	end

	# TEST DESCRITPTION
	# Pass: The About page does contain the phrase 'About Us'
	describe "About page" do
		it "should have the content 'About Us'" do
			visit '/static_pages/about'
			expect(page).to have_content('About Us')
		end
	end
end

