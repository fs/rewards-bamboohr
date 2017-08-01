describe RewardsBamboohr do
  describe ".create_birthday_bonus" do
    let(:bamboohr_birthdays_double) { instance_double(RewardsBamboohr::BamboohrBirthdays) }
    let(:birthday_bonus_double) { instance_double(RewardsBamboohr::BirthdayBonus) }
    let(:bamboohr_birthdays) { fixture("bamboohr_birthdays") }
    let(:base_uri) { "http://rewards-staging.flts.tk/api/v1" }
    let(:template) { "+100 Happy Birthday @%{username}" }

    # rubocop:disable RSpec/ExampleLength
    it "creates bonuses" do
      expect(RewardsBamboohr::BamboohrBirthdays)
        .to receive(:new).with("flatstack", "bamboo-key") { bamboohr_birthdays_double }

      expect(RewardsBamboohr::BirthdayBonus)
        .to receive(:new)
          .with("birthday", "123456", base_uri: base_uri) { birthday_bonus_double }

      expect(bamboohr_birthdays_double)
        .to receive(:today_birthdays) { bamboohr_birthdays }

      expect(birthday_bonus_double)
        .to receive(:create_bonuses).with(bamboohr_birthdays, template: template)

      described_class.create_birthday_bonus
    end
  end
end
