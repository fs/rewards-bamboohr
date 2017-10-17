require "rewards-bamboohr/rollbar"
require "rewards-bamboohr/bamboohr_fetcher"
require "rewards-bamboohr/bonus"
require "rewards-bamboohr/templates"
require "rewards-bamboohr/templates/anniversary"
require "rewards-bamboohr/templates/birthday"
require "rewards"

module RewardsBamboohr
  class Base
    DEFAULT_BASE_URL = "http://rewards.flts.tk/api/v1".freeze

    def self.create_birthday_bonus
      new.create_birthday_bonus
    end

    def self.create_anniversary_bonus
      new.create_anniversary_bonus
    end

    def initialize
      Rewards::Client.base_uri(base_uri)
    end

    def create_birthday_bonus
      birthdays = bamboohr_fetcher.today_birthdays

      Bonus.new(
        token: token,
        template: RewardsBamboohr::Templates::Birthday
      ).create_bonuses(birthdays) if birthdays
    end

    def create_anniversary_bonus
      anniversaries = bamboohr_fetcher.today_anniversaries

      Bonus.new(
        token: token,
        template: RewardsBamboohr::Templates::Anniversary
      ).create_bonuses(anniversaries) if anniversaries
    end

    private

    def bamboohr_fetcher
      BamboohrFetcher.new(
        ENV.fetch("BAMBOOHR_SUBDOMAIN"),
        ENV.fetch("BAMBOOHR_API_KEY")
      )
    end

    def token
      Rewards::Client.new.bot_create_token(
        ENV.fetch("REWARDS_BOT_NAME"),
        ENV.fetch("REWARDS_BOT_PASSWORD")
      )["data"]["attributes"]["token"]
    end

    def base_uri
      ENV.fetch("REWARDS_BASE_URI", DEFAULT_BASE_URL)
    end
  end
end
