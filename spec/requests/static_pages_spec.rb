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
	subject { page }
	describe "Home page" do
		before{ visit root_path }
		it { should have_selector('body', text: 'Sample App')}
		it { should have_title(full_title('')) }
		it { should_not have_title('| Home') }
	end	

	describe "Help page" do	
		before { visit help_path }
		it { should have_selector('body', text: 'Help') }
		it { should have_title(full_title("Help")) }
	end

	describe "About page" do
		before { visit about_path }
		it { should have_selector('body', text: 'About Us') }
		it { should have_title(full_title("About")) }
	end
	describe "Contact Page" do
		before { visit contact_path }
		it { should have_selector('body', text: 'Contact') }
		it { should have_title(full_title("Contact")) }
	end
end






















