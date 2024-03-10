require_relative 'lib/logics'
require_relative 'lib/texts'

f = File.readlines('google-10000-english-no-swears.txt')

def random_selector(arr)
  filter = arr.select {|item| (item.length >= 5)&&(item.length<=12)}
  return filter[rand(filter.length)]
end

secret_word = random_selector(f)
Hangman.new(secret_word)

introduction
response = gets.chomp

if response === '1'
  lives = 8
  running = ['_']

  while (lives > 0) && (running.any?('_')) do
    print "Insert your guess: "
    guess = gets.chomp.downcase
    if guess === 'save'
      Hangman.save
      puts "Your progress has been saved successfully".blue
      break
    end
    running = Hangman.play(guess)
    lives = Hangman.lives
    after_each_turn(lives, running, Hangman.not_in_word)
  end

  if (lives>0)&&(Hangman.not_in_word.length != 8)
    puts "You have won!".green
  elsif (Hangman.not_in_word.length = 8)
    puts "You have lost!".red
    puts "The secret word is #{secret_word}"
  end

else
  file = File.read('saves/save.yaml')
  Hangman.reload(file)
  puts "The last progress was #{Hangman.refractor.join(' ')}"
  lives = Hangman.lives
  running = Hangman.refractor

  while (lives > 0) && (running.any?('_')) do
    print "Insert your guess: "
    guess = gets.chomp.downcase
    if guess === 'save'
      Hangman.save
      puts "Your progress has been saved successfully".blue
      break
    end
    running = Hangman.play(guess)
    lives = Hangman.lives
    after_each_turn(lives, running, Hangman.not_in_word)
  end

  if (lives>0)&&(Hangman.not_in_word.length != 8)
    puts "You have won!".green
  elsif (Hangman.not_in_word.length === 8)
    puts "You have lost!".red
    puts "The secret word is #{Hangman.secret_word}".blue
  end
end
