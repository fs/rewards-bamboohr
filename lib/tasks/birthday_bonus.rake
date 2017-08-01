require File.expand_path("../../birthday_bonus", __FILE__)

namespace :birthday do
  desc "This task gives bonuses when someone has a birthday"
  task :give_bonus do
    bamboohr_users = BamboohrBirthdayUser
      .new(ENV.fetch("BAMBOOHR_SUBDOMAIN"), ENV.fetch("BAMBOOHR_API"))
      .today_birthdays
    BirthdayBonus.new(bamboohr_users).add_bonus unless bamboohr_users.nil?
  end
end
