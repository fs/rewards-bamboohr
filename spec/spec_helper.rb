require "webmock/rspec"
require "timecop"
require "byebug"

require "bamboohr_birthday_user"
require "birthday_bonus"

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end
end
