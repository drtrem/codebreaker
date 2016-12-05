require 'spec_helper'

module Codebreaker
  RSpec.describe Play do
    let(:play) {Play.new}
    let(:game) {Game.new}

    context '#play_game' do
      it 'hint' do

      end

      it 'exit' do

      end

      it '/\A[1-6]{4}\Z/' do

      end

      it 'You should make a guess of 4 numbers from 1 to 6.' do

      end
    end

    context '#play_again' do
      it 'play_again' do

      end
    end

    context '#statisctics' do
      it 'look statisctics' do

      end
    end

    context '#save' do
      after do
        File.delete('./statistics.txt')
      end

      it 'statistics should exist' do
        allow(play).to receive(:puts)
        allow(play).to receive(:gets).and_return('Dima')
        allow(play).to receive(game.statistik).and_return('run')
        play.send(:save)
        expect(File.exist?('./statistics.txt')).to eq(true)
      end
    end
  end
end
