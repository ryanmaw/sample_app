require 'rails_helper'
require 'spec_helper'
require 'pp'

describe User do
	before do
	    @user = User.new(name: "Example User", 
	    				 email: "user@example.com",
	                     password: "foobar", 
	                     password_confirmation: "foobar")
    end

	subject { @user }

	it { should respond_to(:name) }
	it { should respond_to(:email) }
	it { should respond_to(:password_digest) }
	it { should respond_to(:password) }
	it { should respond_to(:password_confirmation) }
	it { should respond_to(:remember_token) }
    it { should respond_to(:authenticate) }
    it { should respond_to(:admin) }

    # This just tests for an attr called microposts; not a very robust test
    it { should respond_to(:microposts) }

	it { should be_valid }

 	#### User Email Tests ####
	describe "when name is not present" do
		before { @user.name = " " }
		it { should_not be_valid }
	end

	describe "when email is not present" do
		before { @user.email = " " }
		it { should_not be_valid }
	end

	describe "when email has mixed case" do
		let(:mixed_case_email) {"FooBar@Gmail.coM"}
		it "should be saved as all lower case" do
			# Create user with mixed case
			@user.email = mixed_case_email
			@user.save
			# Reload and verify it's all lower case
			expect(@user.reload.email).to eq mixed_case_email.downcase
		end
	end

	describe "when email format is invalid" do
		it "should be invalid" do
			addresses = %w[
				user@foo,com user_at_foo.org
				example.user@foo.
				foo@bar_baz.com 
				foobar@gmail..com
				foo@bar+baz.com]
			addresses.each do |invalid_address|
				@user.email = invalid_address
				expect(@user).not_to be_valid
			end
		end
	end

	describe "when email format is valid" do
		it "should be valid" do
			addresses = %w[user@foo.COM 
				A_US-ER@f.b.org
			 	frst.lst@foo.jp 
			 	a+b@baz.cn]
			addresses.each do |valid_address|
				@user.email = valid_address
				expect(@user).to be_valid
			end
		end
	end

	describe "when email address is already taken" do
		before do
			user_with_same_email = @user.dup
			user_with_same_email.email = @user.email.upcase
			user_with_same_email.save
		end
		it { should_not be_valid }
	end

	#### User Name Tests ####
	describe "when name is to long" do
		before { @user.name = 'a' * 51 }
		it { should_not be_valid }
	end
	#### User Password Tests ####
	describe "when password is not present" do
	  before do
	    @user = User.new(name: "Example User", 
	    				 email: "user@example.com",
	                     password: " ",
	                     password_confirmation: " ")
	  end
	  it { should_not be_valid }
	end	

	describe "when password doesn't match confirmation" do
		before { @user.password_confirmation = "mismatch" }
		it { should_not be_valid }
	end

	describe "with a password that's too short" do
	    before { @user.password = @user.password_confirmation = "a" * 5 }
	    it { should be_invalid }
	end

	describe "return value of authenticate method" do
		before { @user.save }
		let(:found_user) { User.find_by(email: @user.email) }

		describe "with valid password" do
			it { should eq found_user.authenticate(@user.password) }
		end

		describe "with invalid password" do
			let(:user_for_invalid_password) { found_user.authenticate("invalid") }

			it { should_not eq user_for_invalid_password }
			specify { expect(user_for_invalid_password).to be_falsey }
		end
	end

	describe "Remember Token" do
		before { @user.save }
		#it{ @user.remember_token.should_not be_blank }
		specify { expect(@user.remember_token).to_not be_blank }
	end

	describe "User's Admin Attribute set to true" do
		before do
			@user.save!
			@user.toggle!(:admin)
		end
		it { should be_admin }
	end

	describe "micropost associations" do

		before { @user.save }

		# let! bang forces created now, let waits to create until referenced

		let!(:older_micropost) do
			FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
		end
		let!(:newer_micropost) do
			FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
		end

		it "should have the right microposts in the right order" do
			@user.microposts.should == [newer_micropost, older_micropost]
		end

		it "should destroy associated microposts" do
			# This differs greatly from the book because rails 4
			# The association dependance arranges for the deletion. 

			microposts = @user.microposts.dup
			@user.destroy
			microposts.should be_empty
		end

	end

end












