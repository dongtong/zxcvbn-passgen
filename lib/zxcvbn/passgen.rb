require "zxcvbn/passgen/version"
require 'zxcvbn'

module Zxcvbn
  module Passgen
    class Error < StandardError; end

    def self.generate(length = 11)
      raise "Password length must be greater or equal 11." if length < 11
      pass = make(length)
      while Zxcvbn.test(pass).score < 4
        generate(length)
      end
      pass
    end

    def self.make(length)
      down    = ('a'..'z').to_a
      up      = ('A'..'Z').to_a
      digits  = ('0'..'9').to_a
      symbols = %i[~ ! @ # $ % ^ & * ( ) + { } ? < > = ].freeze
      all     = down + up + digits + symbols
      [down.sample, up.sample, digits.sample, symbols.sample]
        .concat((length - 4).times.map { all.sample })
        .shuffle
        .join
    end
  end
end
