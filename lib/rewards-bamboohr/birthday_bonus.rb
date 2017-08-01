require "rewards"

module RewardsBamboohr
  class BirthdayBonus
    DEFAULT_BASE_URL = "http://rewards.flts.tk/api/v1".freeze
    DEFAULT_TEMPLATE = "+100 Happy Birthday @%{username}".freeze

    attr_reader :token, :users

    def initialize(name, password, base_uri: DEFAULT_BASE_URL)
      Rewards::Client.base_uri(base_uri)

      @token = create_token(name, password)
      @users = load_users(token)
    end

    def create_bonuses(birthdays, template: DEFAULT_TEMPLATE)
      birthdays.each do |birthday|
        username = find_username(birthday)
        create_bonus(username, template) if username
      end
    end

    private

    def find_username(birthday)
      users.each do |user|
        return user["attributes"]["username"] if user["attributes"]["email"] == birthday["bestEmail"]
      end

      nil
    end

    def create_bonus(username, template)
      Rewards::Client.new(token: token)
        .bot_create_bonus(template % { username: username })
    end

    def create_token(name, password)
      Rewards::Client.new
        .bot_create_token(name, password)["data"]["attributes"]["token"]
    end

    def load_users(token)
      Rewards::Client.new(token: token)
        .bot_users["data"]
    end
  end
end
