require 'rails_helper'
require 'spec_helper'

describe Micropost do

	let(:user){ FactoryGirl.create(:user) }

	before { @micropost = user.microposts.build(content: "This is the content") }

	subject { @micropost }

	it { should respond_to(:content) }
	it { should respond_to(:user_id) }
	it { should respond_to(:user) }

	# requires gem 'rspec-its'
	its(:user) { should == user }

	it { should be_valid }

	describe "when user_id is not present" do
		before { @micropost.user_id = nil }
		it { should_not be_valid }
	end

	describe "With no content" do
		before { @micropost.content = "" }
		it { should_not be_valid }
	end

	describe "with content longer then 140 chars" do
		before { @micropost.content = "a" * 141 }
		it { should_not be_valid }		
	end

end
