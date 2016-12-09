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
      end
    end

    def hint
      return "You don't have any hints." if @hints == 0
      @hints -= 1
      @secret_code.sample
    end

    def game
      answer = []
      array = @code.zip(@secret_code)
      array.each_with_index do |(code, secret_code), i|
        if code == secret_code
          answer[i] = '+'
          array[i][0], array[i][1] = nil
        end
      end
      array.each_with_index do |(code, secret_code), i|
        array.each_with_index do |code, j|
          if secret_code == array[j][0].to_i
            answer[i] = '-'
            array[j][0], array[i][1], secret_code = nil
          end
        end
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
