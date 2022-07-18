class Dictionary
  @@file = File.open("words10000.txt", "r")

  def initialize
    @@words = @@file.readlines
  end

  def pick
    @word = @@words.select do |word|
      word.length > 5 && word.length < 12
    end.shuffle.fetch(0)
  end
end

# class Guess

# end

# class Game

# end

my_dictionary = Dictionary.new
word = my_dictionary.pick

puts word