lib_dir = File.expand_path("lib", File.dirname(__FILE__))
$LOAD_PATH << lib_dir unless $LOAD_PATH.include?(lib_dir)

require "dotenv/load"
require "snitcher"
require "rewards-bamboohr"

namespace :rewards do
  desc "This task gives bonuses when someone has a birthday"
  task :give_bonus do
    RewardsBamboohr.create_birthday_bonus
    Snitcher.snitch(ENV["SNITCH_DAILY"]) if ENV["SNITCH_DAILY"]
  end
end
