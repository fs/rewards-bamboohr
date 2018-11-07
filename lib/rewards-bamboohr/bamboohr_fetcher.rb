require "active_support/core_ext/time/calculations"
require "bamboozled"

module RewardsBamboohr
  class BamboohrFetcher
    attr_reader :client

    def initialize(subdomain, api_key)
      @client = Bamboozled.client(subdomain: subdomain, api_key: api_key)
    end

    def today_birthdays
      employees.each_with_object([]) do |employee, birthday_people|
        birthday_people << employee if today?(employee["dateOfBirth"])
      end
    end

    def today_anniversaries
      employees.each_with_object([]) do |employee, anniversary_people|
        anniversary_people << employee if today?(employee["hireDate"])
      end
    end

    def by_emails(emails)
      employees.each_with_object([]) do |employee, people|
        people << employee if emails.include?(employee["bestEmail"])
      end
    end

    private

    def today?(date_string)
      date = valid_date?(date_string)
      date && month_day(date) == month_day(Date.today)
    end

    def month_day(date)
      date.strftime("%m-%d")
    end

    def employees
      client.employee.all(%w[dateOfBirth hireDate bestEmail])
    end

    def valid_date?(date_string)
      Date.parse(date_string)
    rescue ArgumentError
      false
    end
  end
end
