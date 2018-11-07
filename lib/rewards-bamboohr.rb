require "rewards-bamboohr/rollbar"
require "rewards-bamboohr/bamboohr_fetcher"
require "rewards-bamboohr/bonus"
require "rewards-bamboohr/templates"
require "rewards-bamboohr/templates/anniversary"
require "rewards-bamboohr/templates/birthday"
require "rewards"

module RewardsBamboohr
  class Base
    DEFAULT_BASE_URL = "http://rewards.flatstack.com/api/v1".freeze

    attr_reader :emails

    def initialize(emails = nil)
      @emails = emails

      Rewards::Client.base_uri(base_uri)
    end

    def create_birthday_bonus
      birthdays = fetch_people("birthdays")

      return unless birthdays

      Bonus.new(
        token: token,
        template: RewardsBamboohr::Templates::Birthday
      ).create_bonuses(birthdays)
    end

    def create_anniversary_bonus
      anniversaries = fetch_people("anniversaries")

      return unless anniversaries

      Bonus.new(
        token: token,
        template: RewardsBamboohr::Templates::Anniversary
      ).create_bonuses(anniversaries)
    end

    private

    def fetch_people(event)
      return bamboohr_fetcher.by_emails(emails) if emails.present?

      bamboohr_fetcher.public_send("today_#{event}")
    end

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
