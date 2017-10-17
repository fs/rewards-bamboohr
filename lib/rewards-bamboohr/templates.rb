module RewardsBamboohr
  module Templates
    class Base
      attr_reader :username, :bamboohr_data

      def self.generate(username:, bamboohr_data:)
        new(username, bamboohr_data).generate
      end

      def initialize(username, bamboohr_data)
        @username, @bamboohr_data = username, bamboohr_data
      end
    end
  end
end
