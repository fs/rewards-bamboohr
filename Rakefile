lib_dir = File.expand_path("lib", File.dirname(__FILE__))
$LOAD_PATH << lib_dir unless $LOAD_PATH.include?(lib_dir)

require "dotenv/load"
require "snitcher"
require "rewards-bamboohr"

namespace :rewards do
  desc "This task gives bonuses when someone has a birthday"
  task :give_birthday_bonus do
    RewardsBamboohr::Base.new.create_birthday_bonus
    Snitcher.snitch(ENV["SNITCH_DAILY"]) if ENV["SNITCH_DAILY"]
  end

  desc "This task gives bonuses when someone has an anniversary"
  task :give_anniversary_bonus do
    RewardsBamboohr::Base.new.create_anniversary_bonus
    Snitcher.snitch(ENV["SNITCH_DAILY"]) if ENV["SNITCH_DAILY"]
  end
end
