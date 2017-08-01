describe RewardsBamboohr::BamboohrBirthdays do
  let(:birthdays) { described_class.new("domain", "token") }
  let(:bamboohr_client) { instance_double(Bamboozled::Base) }

  before do
    allow(Bamboozled).to receive(:client).with(subdomain: "domain", api_key: "token") { bamboohr_client }
    allow(bamboohr_client).to receive_message_chain(:employee, :all) { fixture("bamboohr_employees") }
  end

  describe "#today_birthdays" do
    it "returns a birthday person" do
      Timecop.freeze("1991-01-01") do
        expect(birthdays.today_birthdays.first).to include("id" => 123)
        expect(birthdays.today_birthdays.size).to eql(1)
      end
    end
  end
end
