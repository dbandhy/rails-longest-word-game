class GamesController < ApplicationController
  def new
    letters = ('A'..'Z').to_a
    vowels = ['A', 'e', 'i', 'o', 'u']
    @gameLetters = letters.sample(8) + vowels.sample(2)
  end

  def score
    @word = params[:word].downcase
    @letters = params[:letters]
    if word_in_grid?(@word, @letters)
      if valid_english_word?(word)
        @result = "Congrats, #{word} is the answer"
      else
        @result = 'You are wrong. Try again'
      end
    else
      @result = 'Type a valid letter or vowel'
    end
  end

  private

  def word_in_grid?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def valid_english_word?(word)
    url = "dictionary.lewagon.com/#{word}"
    user_serialized = URI.open(url).read
    response = JSON.pasrse(user_serialized)
    response['found']
  end
end
