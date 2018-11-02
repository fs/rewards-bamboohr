describe RewardsBamboohr::Base do
  let(:bamboohr_fetcher_double) { instance_double(RewardsBamboohr::BamboohrFetcher) }
  let(:bonus_double) { instance_double(RewardsBamboohr::Bonus) }
  let(:rewards_client) { instance_double(Rewards::Client) }

  let(:bamboohr_birthdays) { fixture("bamboohr_birthdays") }
  let(:bamboohr_anniversaries) { fixture("bamboohr_anniversaries") }

  before do
    allow(RewardsBamboohr::BamboohrFetcher).to receive(:new).with("flatstack", "bamboo-key") { bamboohr_fetcher_double }
    allow(Rewards::Client).to receive(:new) { rewards_client }
    allow(rewards_client).to receive(:bot_create_token) { fixture("rewards_token") }
    allow(RewardsBamboohr::Bonus).to receive(:new).with(token: "token-id", template: template) { bonus_double }
    allow(bonus_double).to receive(:create_bonuses).with(bamboohr_data)
  end

  describe "bonus create" do
    context "when dealing with birthdays" do
      let(:template) { RewardsBamboohr::Templates::Birthday }
      let(:bamboohr_data) { bamboohr_birthdays }

      it "creates bonuses" do
        expect(bamboohr_fetcher_double).to receive(:today_birthdays) { bamboohr_data }

        described_class.create_birthday_bonus
      end
    end

    context "when dealing with anniversaries" do
      let(:template) { RewardsBamboohr::Templates::Anniversary }
      let(:bamboohr_data) { bamboohr_anniversaries }

      it "creates anniversary bonuses" do
        expect(bamboohr_fetcher_double).to receive(:today_anniversaries) { bamboohr_data }

        described_class.create_anniversary_bonus
      end
    end
  end
end
