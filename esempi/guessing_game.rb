#!/usr/bin/env ruby

puts "Welcome to the Number Guessing Game!"
puts "I'm thinking of a number between 1 and 100."
puts

# Generate random number
secret_number = rand(1..100)
attempts = 0
max_attempts = 10

puts "You have #{max_attempts} attempts to guess the number."
puts

loop do
  print "Enter your guess: "
  guess = gets.chomp.to_i
  attempts += 1
  
  if guess == secret_number
    puts "\n🎉 Congratulations! You guessed it!"
    puts "The number was #{secret_number}."
    puts "You found it in #{attempts} attempt(s)."
    break
  elsif attempts >= max_attempts
    puts "\n😞 Game Over! You've used all #{max_attempts} attempts."
    puts "The secret number was #{secret_number}."
    break
  elsif guess < secret_number
    puts "Too low! Try again. (Attempts remaining: #{max_attempts - attempts})"
  else
    puts "Too high! Try again. (Attempts remaining: #{max_attempts - attempts})"
  end
  
  puts
end

puts "\nThanks for playing!"
