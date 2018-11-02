module RewardsBamboohr
  module Templates
    class Anniversary < Base
      DEFAULT_TEMPLATE = "+100 Happy %<number>s Anniversary @%<username>s".freeze

      def generate
        format(template, username: username, number: anniversary_number)
      end

      private

      def anniversary_number
        ActiveSupport::Inflector.ordinalize(year(Date.today) - year(bamboohr_data["hireDate"]))
      end

      def year(date)
        date.to_date.year
      rescue ArgumentError
        Date.current.year
      end

      def template
        ENV.fetch("REWARDS_ANNIVERSARY_TEMPLATE", DEFAULT_TEMPLATE)
      end
    end
  end
end
