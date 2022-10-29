require_relative "card.rb"

class Deck
attr_accessor :cards

    VALUES=[2,3,4,5,6,7,8,9,10,:J,:Q,:K,:A]
    SUITS=[:H,:S,:D,:C]

    def initialize
        @cards=[]
        fill
    end

    def fill
        SUITS.each do |suit|
            VALUES.each do |val|
              @cards<<Card.new(suit,val)
            end
        end
        true
    end  

    def shuffle_cards
        @cards.shuffle!
    end
end