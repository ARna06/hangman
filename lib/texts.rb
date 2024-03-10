require 'colorize'

def introduction
  print "This is a simple implementation of the game of hangman where the player has to guess a word of length between 5 and 12 characters within 8 lives \n".yellow
  print "You can simply save your current progress simply by typing save in any step.\n\n".green
  print "You may start a new game by entering 1 or load from old save by entering 2\n".cyan
end

def after_each_turn (lives, running_guess, running_incorrect)
  puts "#{running_guess.join(' ')}"
  puts "You have #{lives} lives left out of 8 lives".blue
  puts "The word does not contain the letters: #{running_incorrect.join(', ')}".red
end
