require "rewards-bamboohr/rollbar"
require "rewards-bamboohr/bamboohr_birthdays"
require "rewards-bamboohr/birthday_bonus"

module RewardsBamboohr
  def self.create_birthday_bonus
    birthdays = BamboohrBirthdays
      .new(ENV.fetch("BAMBOOHR_SUBDOMAIN"), ENV.fetch("BAMBOOHR_API_KEY"))
      .today_birthdays

    BirthdayBonus.new(
      ENV.fetch("REWARDS_BOT_NAME"),
      ENV.fetch("REWARDS_BOT_PASSWORD"),
      base_uri: ENV.fetch("REWARDS_BASE_URI")
    ).create_bonuses(birthdays, template: ENV.fetch("REWARDS_TEMPLATE")) if birthdays
  end
end
