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
      no_attempts
      @code = code.split('').map(&:to_i)
      @attempts -= 1
      win
      mark
    end

    def exit_with_status(message)
      @exit = true
      @status = message
    end

    def win
      return exit_with_status('Congratulations, you win!') if @code == @secret_code
    end

    def no_attempts
      return exit_with_status('Game over! You have no more attempts') if @attempts == 0
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
