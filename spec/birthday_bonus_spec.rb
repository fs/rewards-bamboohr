describe BirthdayBonus do
  def stub_rewards_request(path, body = "")
    stub_request(:any, "http://rewards-staging.flts.tk/api/v1/bot#{path}")
      .to_return(status: 200, body: body)
  end

  before do
    stub_rewards_request("/tokens", File.new("spec/fixtures/bot_token_request.json"))
    stub_rewards_request("/users", File.new("spec/fixtures/rewards_users.json"))
    stub_rewards_request("/bonuses")
  end

  let(:birthday_users_fixture_content) { File.new("spec/fixtures/employee_123.json").read }
  let(:birthday_users) { [JSON.parse(birthday_users_fixture_content)] }
  let(:request_body) { JSON.parse(File.new("spec/fixtures/bonus_request.json").read.to_s) }

  it "calls give bonus api if there are birthday people" do
    described_class.new(birthday_users).add_bonus
    expect(a_request(:post, "http://rewards-staging.flts.tk/api/v1/bot/bonuses")
      .with(body: JSON.generate(request_body)))
      .to have_been_made
  end
end
