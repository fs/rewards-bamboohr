require "active_support/core_ext/time/calculations"
require "bamboozled"

module RewardsBamboohr
  class BamboohrBirthdays
    attr_reader :client

    def initialize(subdomain, api_key)
      @client = Bamboozled.client(subdomain: subdomain, api_key: api_key)
    end

    def today_birthdays
      birthday_people = []

      employees.each do |employee|
        birthday_people << employee if birthday_user?(employee["dateOfBirth"])
      end

      birthday_people
    end

    private

    def birthday_user?(date_string)
      date = valid_date?(date_string)
      date && month_day(date) == month_day(Date.today)
    end

    def month_day(date)
      date.strftime("%m-%d")
    end

    def employees
      client.employee.all(%w(dateOfBirth bestEmail))
    end

    def valid_date?(date_string)
      Date.parse(date_string)
    rescue
      false
    end
  end
end
