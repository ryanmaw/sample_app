

require 'capybara/rspec'

RSpec.configure do |config|
  config.include Capybara::DSL
end


# RSpec.configure do |config|
#   config.expect_with :rspec do |c|
#     c.syntax = [:should, :expect]
#   end
# end