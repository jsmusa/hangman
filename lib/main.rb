class Dictionary
  @@file = File.open("words10000.txt", "r")

  def initialize
    @@words = @@file.readlines.map {|line| line.chomp}
  end

  def pick
    @word = @@words.select do |word|
      word.length > 5 && word.length < 12
    end.sample
  end
end

class Guess
  attr_reader :list

  def initialize(word)
    @secret_word = word
    @list = []
  end

  def ask
    loop do
      puts "Enter your guess (single character):"
      input = gets.chomp.downcase
      
      unless input.match?(/[A-Za-z]{1}/) && input.length == 1
        puts "Invalid input, please try again"
        redo
      else
        @list.push(input)
        break
      end
    end 
  end

  def wrong_tries 
    @list.difference(@secret_word.split("")).length
  end
end

class Game
  def initialize
    @dictionary = Dictionary.new
    @word = @dictionary.pick
    @guess = Guess.new(@word)
    @display = nil
  end
  
  def compare(word, *char)
    @display = word.gsub(/[^#{char}]/, "_")
  end

  def display
    compare(@word, @guess.list)
    puts @display.to_s.split("").join(" ")
  end

  def check
    unless @word.include?(@guess.list.last)
      puts "Wrong guess, #{@guess.list.last} is not found in the word"
      puts "#{10 - @guess.wrong_tries} tries remaining\n\n"
    end
  end

  def play
    until @guess.wrong_tries > 10
      @guess.ask()
      check()
      display()
      puts "Guess list: #{@guess.list.join(" ")}\n\n"
    end

    puts "Game Over!, the secret word is #{@word}."
  end
end

my_game = Game.new
my_game.play

# dictionary = Dictionary.new
# my_word = "dictionary"
# puts my_word

# my_game = Game.new(my_word)

# my_game.guess.push("a")
# my_game.check

# my_game.guess.push("i")
# my_game.check

# my_game.guess.push("m")
# my_game.check