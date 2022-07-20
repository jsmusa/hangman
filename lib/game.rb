class Game
  def initialize
    @dictionary = Dictionary.new
    @word = @dictionary.pick
    @guess = Guess.new(@word)
    @result = ''
  end

  def compare(word, *char)
    @display = word.gsub(/[^#{char}]/, '_')
  end

  def check
    @result = if @guess.list.include?(@guess.input)
                "You've already guessed this! Try again\n".yellow
              elsif @word.include?(@guess.input)
                "Nice try!\n".green
              else
                "Unfortunately, #{@guess.input} is not found in the word\n".magenta
              end
  end

  def input
    @guess.list.push(@guess.input).uniq!
  end

  def display
    compare(@word, @guess.list)

    puts `clear`
    puts @display.to_s.split('').join(' ')
    puts "#{10 - @guess.wrong_tries} wrong guess(es) remaining\n".cyan
    puts "Guess list: #{@guess.list.drop(1).join(' ')}\n\n"
    puts @result
  end

  def save_game
    puts "\nEnter the name for your save file"
    file_name = gets.chomp

    File.open("./save/#{file_name}.yaml", 'w') do |file|
      file.write YAML.dump(self)
    end
  end

  def load_game
    puts Dir.glob('*.yaml', base: 'save').map { |file| File.basename(file, '.yaml') }
    puts "\nChoose your load file from above or enter 'quit' to start a new game"
    loop do
      input = gets.chomp
      file_name = File.join('save', "#{input}.yaml")

      if File.exist?(file_name)
        return YAML.load_file(file_name, permitted_classes: [Game, Dictionary, Guess])
      elsif input == 'quit'
        return self
      else
        puts "#{input} isn't a save file"
      end
    end
  end

  def play
    until @guess.wrong_tries >= 10
      display

      if @word == @display
        puts "Congratulations, You WIN!\n".bold.green
        return
      end

      @guess.ask

      if @guess.input == 'save'
        save_game
        puts "\nSee you again!"
        return
      end

      check
      input
    end

    display
    puts "Game Over! The secret word is #{@word}.\n".bold.light_red
  end
end
