describe RewardsBamboohr::Bonus do
  let(:bonus) { described_class.new(token: "token", template: template) }
  let(:rewards_client) { instance_double(Rewards::Client) }
  let(:birthdays) { fixture("bamboohr_birthdays") }
  let(:anniversaries) { fixture("bamboohr_anniversaries") }

  before do
    allow(Rewards::Client).to receive(:new) { rewards_client }
    allow(rewards_client).to receive(:bot_users) { fixture("rewards_users") }
  end

  describe "#create_bonuses" do
    context "when birthday template is set" do
      let(:template) { RewardsBamboohr::Templates::Birthday }

      it "creates bonuses for birthdays" do
        expect(rewards_client).to receive(:bot_create_bonus).with("+100 Happy Birthday @john.doe")
        expect(rewards_client).not_to receive(:bot_create_bonus).with("+100 Happy Birthday @john.smith")

        bonus.create_bonuses(birthdays)
      end
    end

    context "when anniversary template is set" do
      let(:template) { RewardsBamboohr::Templates::Anniversary }

      it "creates bonuses for anniversaries" do
        Timecop.freeze("2020-05-09") do
          expect(rewards_client).to receive(:bot_create_bonus).with("+100 Happy 3rd Anniversary @john.smith")
          expect(rewards_client).not_to receive(:bot_create_bonus).with("+100 Happy 3rd Anniversary @john.doe")

          bonus.create_bonuses(anniversaries)
        end
      end
    end
  end
end
