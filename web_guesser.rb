require 'sinatra'
require 'sinatra/reloader'

NUMBER = rand(100)

# def number
#   @number ||= rand(100)
# end

def check_guess(guess)
  diff = (NUMBER - guess.to_i).abs
  if guess == nil
    ""
  elsif guess.to_i > NUMBER
    if diff > 5
      "Way too hi!"
    else
      "Too hi"
    end
  elsif guess.to_i < NUMBER
    if diff > 5
      "Way too low!"
    else
      "Too low"
    end
  elsif guess.to_i == NUMBER
    "You got it right!\nThe SECRET NUMBER is #{NUMBER}"   
  end
end

get '/' do
  guess = params["guess"]
  message = check_guess(guess)
  erb :index, :locals => {:number => NUMBER, :message => message}
end