describe RewardsBamboohr::BirthdayBonus do
  let(:birthday_bonus) { described_class.new("name", "password") }
  let(:rewards_client) { instance_double(Rewards::Client) }
  let(:birthdays) { fixture("bamboohr_birthdays") }

  before do
    allow(Rewards::Client).to receive(:new) { rewards_client }
    allow(rewards_client).to receive(:bot_create_token) { fixture("rewards_token") }
    allow(rewards_client).to receive(:bot_users) { fixture("rewards_users") }
  end

  describe "#create_bonuses" do
    it "creates bonuses for birthdays" do
      expect(rewards_client).to receive(:bot_create_bonus).with("+100 Happy Birthday @john.doe")
      expect(rewards_client).not_to receive(:bot_create_bonus).with("+100 Happy Birthday @john.smith")

      birthday_bonus.create_bonuses(birthdays)
    end
  end
end
