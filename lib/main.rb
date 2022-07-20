# frozen_string_literal: true

require 'colorize'
require 'yaml'
require_relative 'guess'
require_relative 'game'
require_relative 'dictionary'

my_game = Game.new

loop do
  puts `clear`
  puts "Press 1 to play new game or 2 to load game\n[1] New game\n[2] Load game"
  input = gets.chomp

  case input
  when '2'
    my_game = my_game.load_game
    sleep 1
    break
  when '1'
    break
  end
end

my_game.play
