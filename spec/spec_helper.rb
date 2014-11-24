

require 'capybara/rspec'

RSpec.configure do |config|
  config.include Capybara::DSL
  
  # Enable :should to remove the deprecated warning 
  config.expect_with :rspec do |c|
    c.syntax = [:should, :expect]
  end

end



# Enable :should to remove the deprecated warning 
# RSpec.configure do |config|
#   config.expect_with :rspec do |c|
#     c.syntax = [:should, :expect]
#   end
# end