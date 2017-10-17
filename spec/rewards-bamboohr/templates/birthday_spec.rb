describe RewardsBamboohr::Templates::Birthday do
  let(:username) { "Claire" }
  let(:bamboohr_data) { {} }
  let(:template) do
    described_class.generate(
      username: username,
      bamboohr_data: bamboohr_data
    )
  end

  describe ".generate" do
    it "generates birthday template" do
      expect(template).to eq("+100 Happy Birthday @Claire")
    end
  end
end
