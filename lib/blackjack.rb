#!/usr/bin/env ruby
require 'pry'

class Card
  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def type
    faces = ['J', 'Q', 'K']
    if faces.include? value
      return 'face'
    elsif value == 'A'
      return 'ace'
    else
      return 'numeric'
    end
  end

end

SUITS = ['♦', '♠', '♥', '♣']
VALUES = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']

class Deck
  attr_accessor :collection

  def initialize
    @collection = []
    SUITS.each do |suit|
      VALUES.each do |value|
        @collection << Card.new(suit, value)
      end
    end
    @collection.shuffle!
  end

  def deck_total
    @collection.size
  end

  def draw!
    @collection.pop
  end

end

class Hand
  attr_accessor :cards

  def initialize
    @cards = []
  end

  def add_card(card)
    @cards << card
  end

  def best_score
    score = 0
    ace_array = []
    @cards.each do |card|
      if card.type == 'face'
        score += 10
      elsif card.type == 'numeric'
        score += card.value.to_i
      elsif card.type == 'ace'
        ace_array << card
      end
    end
      score += ace_calculation(score, ace_array)
      score
  end

  def ace_calculation(score, ace_array)
    if ace_array.size == 0
      return 0
    elsif ace_array.size == 1
      if score + 11 > 21
        return 1
      else
        return 11
      end
    elsif ace_array.size > 1
      return ace_array.size
    end
  end

end

# deck = Deck.new
# hand = Hand.new
# hand.add_card(deck.draw!)

class Game
  attr_accessor :deck, :player_hand, :dealer_hand, :user_input

  def initialize(deck, player_hand, dealer_hand)
    @deck = deck
    @player_hand = player_hand
    @dealer_hand = dealer_hand
  end

  def welcome
    "Welcome to Blackjack!"
  end

  def deal(whose_hand, their_name)
    whose_hand.add_card(@deck.draw!)
    message = "#{their_name} was dealt #{whose_hand.cards[0].value}#{whose_hand.cards[0].suit}"
  end

  def prompt_player(player_choice)

    while player_choice != 's'
      if player_choice == 'h'
        deal(player_hand, "Player")
      elsif player_choice != 'h'
        "Input is invalid, try again"
        break
      end
    end
    # stand
  end

end

# def new_game
#   Game.new(Deck.new, Hand.new, Hand.new)
#   game.welcome
#   game.deal(game.player_hand, "Player")
#   puts "Hit or stand (H/S):"
#   player_choice = gets.chomp.downcase
#   game.prompt_player(player_choice)
#  end
#
# new_game
