require "dotenv"
require "httparty"
require "pry-rails"
require_relative "bamboohr_birthday_user"
require "rewards"

Dotenv.load

class BirthdayBonus
  attr_reader :rewards_users, :birthday_users

  def initialize(birthday_users)
    Rewards::Client.base_uri("http://rewards-staging.flts.tk/api/v1")
    @rewards_users = Rewards::Client.new(token: bot_token).bot_users["data"]
    @birthday_users = birthday_users
  end

  def add_bonus
    rewards_users.each do |rewards_user|
      birthday_users.each do |birthday_user|
        if birthday_user["bestEmail"] == rewards_user["attributes"]["email"]
          create_bonus_message(rewards_user["attributes"]["username"])
        end
      end
    end
  end

  private

  def create_bonus_message(username)
    Rewards::Client.new(token: bot_token)
      .bot_create_bonus("Testing bots +100 @#{username} #be-curious-never-stop-learning")
  end

  def bot_token
    Rewards::Client.new.bot_create_token("birthday", "123456")["data"]["attributes"]["token"]
  end
end
