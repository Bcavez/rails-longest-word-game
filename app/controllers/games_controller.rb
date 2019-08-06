require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    @message = valid(params[:answer], params[:token])
    @score = 1
  end

  private

  def valid(answer, letters)
    if english(answer) == false
      "Sorry but #{answer} is not an english word..."
    elsif compare(answer, letters) == false
      "Sorry but #{answer} can't be build out of #{letters}..."
    else
      'Congratulations!'
    end
  end

  def english(answer)
    url = "https://wagon-dictionary.herokuapp.com/#{answer}"
    page = open(url).read
    result = JSON.parse(page)
    result['found']
  end

  def compare(answer, letters)
    answer = answer.upcase.split('').sort
    letters = letters.split(' ').sort
    answer_return = answer.find_all { |letter| letters.include?(letter) }
    letters_return = letters.find_all { |letter| answer.include?(letter) }
    if answer.length <= letters_return.length
      if answer == answer_return
        return true
      else return false
      end
    else return false
    end
  end
end
