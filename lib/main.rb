class Dictionary
  @@file = File.open("words10000.txt", "r")

  def initialize
    @@words = @@file.readlines
  end

  def pick
    @word = @@words.select do |word|
      word.length > 5 && word.length < 12
    end.sample
  end
end

class Game
  attr_accessor :guess

  def initialize(word)
    @secret_word = word
    @guess = []
  end

  def check
    if @secret_word.include?(@guess.last)
      display(@guess)
      puts @display
    else
      puts "Wrong answer"
    end
  end

  def display(*char)
    @display = @secret_word.gsub(/[^#{char}]/, " ")
  end
end

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