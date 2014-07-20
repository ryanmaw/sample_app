require 'rails_helper'

describe User do
	before { @user = User.new(name: "example", email:"example@gmail.com") }
	subject { @user }
end
