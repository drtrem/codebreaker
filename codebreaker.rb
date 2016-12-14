require "codebreaker/version"

module Codebreaker
  class Game
    NUMBER_ATTEMPTS = 3
    HINTS = 1

    attr_reader :attempts, :hints

    def initialize
      @secret_code = random
      @attempts = NUMBER_ATTEMPTS
      @hints = HINTS
      @exit = false
    end

    def random
      (1..4).map {rand(1..6)}
    end

    def guess(code)
      if @attempts == 0
        @exit = true
        return @status = 'Game over! You have no more attempts'
      end
      @code = code.split('').map(&:to_i)
      @attempts -= 1
      if @code == @secret_code
        @exit = true
        return @status = 'Congratulations, you win!'
      else
        mark
      end
    end

    def hint
      return "You don't have any hints." if @hints == 0
      @hints -= 1
      @secret_code.sample
    end

    def mark
      array_code = Array.new(@code)
      array_secret_code = Array.new(@secret_code)
      answer = []
      array_code.zip(array_secret_code).each_with_index do |(code, secret_code), i|
        next if code != secret_code
          array_secret_code[i], array_code[i] = nil
          answer << '+'
      end
      array_code.compact!
      array_secret_code.compact!
      array_code.map do |code|
        index = code && array_secret_code.index(code)
        next unless index
          array_secret_code[index] = nil
          answer << '-'
      end
      answer.join if @exit == false
    end

    def exit?
      @exit
    end

    def statistik
      "Status: #{@status}, Secret code: #{@secret_code}, attempts left: #{@attempts}, hints left: #{@hints}"
    end
  end
end
