require "colorize"
require "yaml"

class Dictionary
  @@file = File.open("words10000.txt", "r")

  def initialize
    @@words = @@file.readlines.map {|line| line.chomp}
    @@file.close
  end

  def pick
    @word = @@words.select do |word|
      word.length > 5 && word.length < 12
    end.sample
  end
end

class Guess
  attr_reader :list, :input

  def initialize(word)
    @secret_word = word
    @list = [""]
  end

  def ask
    loop do
      puts "Enter your guess (single character) or 'save' to save:"
      @input = gets.chomp.downcase
      if @input == "save"
        break
      elsif @input.match?(/[A-Za-z]{1}/) && @input.length == 1
        break
      end

      puts "Invalid input, please try again".red
    end 
  end

  def wrong_tries 
    @list.difference(@secret_word.split("")).length - 1
  end
end

class Game
  def initialize
    @dictionary = Dictionary.new
    @word = @dictionary.pick
    @guess = Guess.new(@word)
    @result = ""
  end
  
  def compare(word, *char)
    @display = word.gsub(/[^#{char.to_s}]/, "_")
  end

  def check
    if @guess.list.include?(@guess.input)
      @result = "You've already guessed this! Try again\n".yellow
    elsif @word.include?(@guess.input)
      @result = "Nice try!\n".green
    else  
      @result = "Unfortunately, #{@guess.input} is not found in the word\n".magenta
    end
  end

  def input
    @guess.list.push(@guess.input).uniq!
  end

  def display
    compare(@word, @guess.list)

    puts `clear`
    puts @display.to_s.split("").join(" ")
    puts "#{10 - @guess.wrong_tries} wrong guess(es) remaining\n".cyan
    puts "Guess list: #{@guess.list.drop(1).join(" ")}\n\n"
    puts @result
  end

  def save_game
    puts "\nEnter the name for your save file"
    file_name = gets.chomp

    File.open("./save/#{file_name}.yaml", "w") do |file|
      file.write YAML::dump(self)
    end  
  end

  def load_game
    
  end

  def play
    until @guess.wrong_tries >= 10
      display()

      if @word == @display
        puts "Congratulations, You WIN!\n".bold.green
        return
      end

      @guess.ask()

      if @guess.input == "save"
        save_game()
        puts "\nSee you again!"
        return
      end

      check()
      input()
    end

    display()
    puts "Game Over! The secret word is #{@word}.\n".bold.light_red
  end
end

my_game = Game.new

puts "Press 1 to play new game or 2 to load game\n[1] New game\n[2] Load game"
my_game.play


# p load_file
# new_game = YAML.load_file("./save/sample.yaml", permitted_classes: [Game, Dictionary, Guess])
# p new_game
# new_game.play