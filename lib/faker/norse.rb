# lib/faker/norse.rb
module Faker
  class Norse < Base
    class << self
      def name
        parse('norse.name')
      end
    end
  end
end