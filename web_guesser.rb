require 'sinatra'
require 'sinatra/reloader'

@@number = rand(100)
@@turns = 6
@@winning_number
@@guesses = []

def has_turns?
  @@turns > 1
end

def reset_game
    @@turns = 5
    @@number = rand(100)
    @@guesses =[]
end

def check_guess(guess)
  @@guesses << guess
  diff = (@@number - guess.to_i).abs
  if has_turns?
    @@turns -= 1
    if guess == nil
      "Please enter a guess"
    elsif guess == ""
      "You must enter a guess"
    elsif guess.to_i > @@number
      how_high(diff)
    elsif guess.to_i < @@number
      how_low(diff)
    elsif guess.to_i == @@number
      @@winning_number = @@number
      reset_game
      "You got it right!\nThe secret number is #{@@winning_number}"  
    end
  else
    reset_game
    "Reset turns"
  end
end

def how_high(diff)
  if diff > 5
      "Way too hi!"
    else
      "Too hi"
  end
end

def how_low(diff)
  if diff > 5
    "Way too low!"
  else
    "Too low"
  end
end

def color_picker(guess)
  diff = (@@number - guess.to_i).abs
  if guess == nil
    ""
  elsif guess == ""
    "FFFFF"
  elsif guess.to_i > @@number
    if diff > 5
      "CF4647"
    else
      "EB7B59"
    end
  elsif guess.to_i < @@number
    if diff > 5
      "CF4647"
    else
      "EB7B59"
    end
  elsif guess.to_i == @@number
    "A7C5BD"  
  end
end

get '/' do
  guess = params["guess"]
  guesses = @@guesses
  color = color_picker(guess)
  message = check_guess(guess)
  turns = @@turns
  number = @@number
  erb :index, :locals => {:number => number, :message => message, :color => color, :turns => turns, :guesses => guesses}
end