class Dictionary
  @@file = File.open('words10000.txt', 'r')

  def initialize
    @@words = @@file.readlines.map { |line| line.chomp }
    @@file.close
  end

  def pick
    @word = @@words.select do |word|
      word.length > 5 && word.length < 12
    end.sample
  end
end
