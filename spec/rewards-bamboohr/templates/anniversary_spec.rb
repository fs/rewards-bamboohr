describe RewardsBamboohr::Templates::Anniversary do
  let(:username) { "Francis" }
  let(:bamboohr_data) do
    { "hireDate" => 3.years.ago.to_s }
  end
  let(:template) do
    described_class.generate(
      username: username,
      bamboohr_data: bamboohr_data
    )
  end

  describe ".generate" do
    it "generates anniversary template" do
      expect(template).to eq("+100 Happy 3rd Anniversary @Francis")
    end
  end
end
