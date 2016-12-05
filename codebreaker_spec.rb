require 'spec_helper'

module Codebreaker
  RSpec.describe Codebreaker do
    let(:game) {Game.new}

    context '#start' do
      it 'saves secret code' do
        expect(game.instance_variable_get(:@secret_code)).not_to be_empty
      end

      it 'saves 4 numbers secret code' do
        expect(game.instance_variable_get(:@secret_code).size).to eq(4)
      end

      it 'saves secret code with numbers from 1 to 6' do
        expect(game.instance_variable_get(:@secret_code)).to match(/\A[1-6]{4}\Z/)
      end
    end

    context '#guess' do
      it 'reduce attempts number by 1' do
        expect{game.guess(1234)}.to change{game.attempts}.by(-1)
      end

      it 'when win' do
        game.instance_variable_set(:@secret_code, 1234)
        expect(game.guess(1234)).to eq('Congratulations, you win!')
      end

      it 'when game over' do
        game.instance_variable_set(:@attempts, 0)
        expect(game.guess(1234)).to eq('Game over! You have no more attempts')
      end

      it '@exit = 1' do
        game.instance_variable_set(:@exit, 1)
        game.guess(1234)
        expect(game.instance_variable_get(:@exit)).to eq(1)
      end
    end

    context '#hint' do
      it 'reduce hint number by 1' do
        expect{game.hint}.to change{game.hints}.by(-1)
      end

      it "You don't have any hints." do
        game.instance_variable_set(:@hints, 0)
        expect(game.hint).to eq("You don't have any hints.")
      end

      it 'return one number of secret code' do
        expect(game.instance_variable_get(:@secret_code)).to include(game.hint)
      end
    end

    context '#game' do
      [['1234', '1040', '+-'], ['1111', '1221', '+--+'], ['1234', '0140', '--'],
      ['1111', '1111', '++++'], ['5656', '1221', ''], ['4410', '0014', '--+-']].each do |item|
        it "Secret code is #{item[0]}, guess #{item[1]}, return #{item[2]}" do
          game.instance_variable_set(:@secret_code, item[0])
          game.instance_variable_set(:@exit, nil)
          game.instance_variable_set(:@code, item[1])
          expect(game.game).to eq(item[2])
        end
      end
    end

    context '#exit?' do
      it 'return false if no attempts' do
        game.instance_variable_set(:@attempts, 0)
        expect(game.exit?).to eq(false)
      end
    end

    context '#statistik' do
      it 'return statistik' do
        expect(game.statistik).to be_is_a(String)
      end
    end
  end
end
