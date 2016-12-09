require 'spec_helper'

module Codebreaker
  RSpec.describe Play do
    subject(:play) {Play.new}

    context '#play_game' do
      before do
        allow(play.instance_variable_get(:@game)).to receive(:exit?).and_return(false)
      end

      it 'greet message' do
        allow(play).to receive(:gets).and_return('exit')
        expect{play.play_game}.to output(/Codebreaker! Make a guess of 4 numbers from 1 to 6./).to_stdout
      end

      it 'print warning massege if wrong input' do
        allow(play).to receive(:gets).and_return('12345')
        expect{play.play_game}.to output(/You should type a guess of four numbers from 1 to 6./).to_stdout
      end

      it 'print answer' do
        allow(play).to receive(:gets).and_return('[1,2,3,4]')
        allow(play.instance_variable_get(:@game)).to receive(:guess).and_return('----')
        expect{play.play_game}.to output(/----/).to_stdout
      end

      it 'message hint' do
        allow(play).to receive(:gets).and_return('hint')
        allow(play.instance_variable_get(:@game)).to receive(:hint).and_return('hint')
        expect{play.play_game}.to output(/hint/).to_stdout
      end

      it 'call #guess method' do
        allow(play).to receive(:puts)
        allow(play).to receive(:gets).and_return('[1,2,3,4]')
        expect(play.instance_variable_get(:@game)).to receive(:guess)
        play.play_game
      end
    end

    context '#play_again' do
      before do
        allow(play).to receive(:play_game)
        allow(play).to receive(:gets).and_return('y')
      end

      it 'ask about play again' do
        expect{play.send(:play_again)}.to output(/Would you like to play again?/).to_stdout
      end

      it "create new game" do
        allow(play).to receive(:puts)
        expect(Game).to receive(:new)
        play.send(:play_again)
      end

      it "call #play_game method" do
        allow(play).to receive(:puts)
        expect(play).to receive(:play_game)
        play.send(:play_again)
      end
    end

    context '#statisctics' do
      it 'look statisctics' do
        allow(File).to receive(:open)
        allow(play).to receive(:gets).and_return('y')
        expect{play.send(:statisctics)}.to output(/Would you like look statisctics? (y,n)/).to_stdout
      end
    end

    context '#save' do
      before do
        allow(play).to receive(:gets).and_return('y')
      end

      it 'ask about save statistics' do
        expect{play.send(:save)}.to output(/Would you like to save game result?/).to_stdout
      end

      it "call #save method" do
        allow(play).to receive(:puts)
        play.send(:save)
      end

      it 'statistics should exist' do
        allow(play).to receive(:puts)
        play.send(:save)
        expect(File.exist?('./statistics.txt')).to eq(true)
      end
    end
  end
end
