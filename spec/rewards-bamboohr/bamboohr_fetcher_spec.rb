describe RewardsBamboohr::BamboohrFetcher do
  let(:fetcher) { described_class.new("domain", "token") }
  let(:bamboohr_client) { instance_double(Bamboozled::Base) }

  before do
    allow(Bamboozled)
      .to receive(:client)
        .with(subdomain: "domain", api_key: "token") { bamboohr_client }
    allow(bamboohr_client)
      .to receive_message_chain(:employee, :all) { fixture("bamboohr_employees") }
  end

  describe "#today_birthdays" do
    it "returns a birthday person" do
      Timecop.freeze("1991-01-01") do
        expect(fetcher.today_birthdays.first).to include("id" => 123)
        expect(fetcher.today_birthdays.size).to eql(1)
      end
    end
  end

  describe "#today_anniversaries" do
    it "returns an anniversary person" do
      Timecop.freeze("2020-05-09") do
        expect(fetcher.today_anniversaries.first).to include("id" => 124)
        expect(fetcher.today_anniversaries.size).to eql(1)
      end
    end
  end

  describe "#by_emails" do
    let(:emails) { ["john.smith@example.com"] }

    it "returns person with certain email" do
      expect(fetcher.by_emails(emails).first).to include("id" => 124)
      expect(fetcher.by_emails(emails).size).to eql(1)
    end
  end
end
