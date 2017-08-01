describe BamboohrBirthdayUser do
  let(:birthdays) { described_class.new("domain", "token") }

  def stub_bamboohr_request(path, fixture)
    stub_request(:get, "https://api.bamboohr.com/api/gateway.php/domain/v1/employees#{path}")
      .to_return(status: 200, body: File.new("spec/fixtures/#{fixture}.json"))
  end

  before do
    stub_bamboohr_request("/directory", "employees")
    stub_bamboohr_request("/123?fields=dateOfBirth,bestEmail", "employee_123")
    stub_bamboohr_request("/124?fields=dateOfBirth,bestEmail", "employee_124")
  end

  it "returns a birthday person" do
    Timecop.freeze("1991-01-01") do
      expect(birthdays.today_birthdays.first).to include("id" => 123)
      expect(birthdays.today_birthdays.size).to eql(1)
    end
  end
end
