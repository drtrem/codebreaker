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
      @exit = nil
    end

    def random
      random = ''
      4.times {random += rand(1..6).to_s}
      random
    end

    def guess(code)
      @code = code
      if @attempts == 0
        @exit = 1
        return @status = 'Game over! You have no more attempts'
      end
      @attempts -= 1
      if @code == @secret_code
        @exit = 1
        return @status = 'Congratulations, you win!'
      end
    end

    def hint
      return "You don't have any hints." if @hints == 0
      @hints -= 1
      @secret_code[rand(4)]
    end

    def game
      array_code = @code.chars
      array_secrets = @secret_code.chars
      @answer = []
      array_code.zip(array_secrets).each_with_index do |(code, secret_code), index|
        if code == secret_code
          @answer[index] = '+'
        else
          array_code.each_with_index do |code|
            @answer[index] = '-' if code == secret_code
          end
        end
      end
      @answer.compact.join('') if @exit == nil
    end

    def exit?
      @exit ? true : false
    end

    def statistik
      "Status: #{@status}, Secret code: #{@secret_code}, attempts left: #{@attempts}, hints left: #{@hints}"
    end
  end
end
