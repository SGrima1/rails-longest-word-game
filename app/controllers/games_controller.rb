require 'json'
require 'open-uri'

class GamesController < ApplicationController
  
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end
  
  def score
    @result = params[:new]
    url = "https://wagon-dictionary.herokuapp.com/#{@result}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    letters = params[:letters]
    @exist = user['found']
    @sum = 0
    array_letters = letters.split(",")
    @result.split("").each do |letter|
       @sum += 1 if array_letters.include?(letter)
    end

    
    case 
    when @exist == true && @result.length == @sum
      @result = @sum
    when @exist == true && @result.length != @sum
      @result = "Sorry but #{@result.upcase} cannot be built out of #{letters}" 
    when @exist != true && @result.length == @sum
      @result = "This is not an english word"
    else 
      @result = "you suck!"
    end
  end
end
