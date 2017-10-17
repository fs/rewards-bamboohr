require "rewards"

module RewardsBamboohr
  class Bonus
    attr_reader :token, :users, :template

    def initialize(token:, template:)
      @token, @template = token, template
      @users = load_users(token)
    end

    def create_bonuses(bamboohr_users)
      bamboohr_users.each do |bamboohr_user|
        username = find_username(bamboohr_user)
        create_bonus(username, bamboohr_user) if username
      end
    end

    private

    def find_username(bamboohr_user)
      users.each do |user|
        return user["attributes"]["username"] if user["attributes"]["email"] == bamboohr_user["bestEmail"]
      end

      nil
    end

    def create_bonus(username, bamboohr_user)
      bonus = generate_from_template(username, bamboohr_user)

      Rewards::Client.new(token: token)
        .bot_create_bonus(bonus)
    end

    def load_users(token)
      Rewards::Client.new(token: token)
        .bot_users["data"]
    end

    def generate_from_template(username, bamboohr_user)
      template.generate(
        username: username,
        bamboohr_data: bamboohr_user
      )
    end
  end
end
