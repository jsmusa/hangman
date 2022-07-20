class Guess
  attr_reader :list, :input

  def initialize(word)
    @secret_word = word
    @list = ['']
  end

  def ask
    loop do
      puts "Enter your guess (single character) or 'save' to save:"
      @input = gets.chomp.downcase
      if @input == 'save'
        break
      elsif @input.match?(/[A-Za-z]{1}/) && @input.length == 1
        break
      end

      puts 'Invalid input, please try again'.red
    end
  end

  def wrong_tries
    @list.difference(@secret_word.split('')).length - 1
  end
end
