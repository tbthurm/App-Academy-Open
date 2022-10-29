require_relative 'deck.rb'
require_relative 'card.rb'

class Hand
attr_accessor :cards, :sp_cards
attr_reader :sp_hand, :order

    def initialize(cards)
        @cards=cards
        @sp_cards=[]
        @order=%w(hc pa tpa tk fl fh fk sf rf)
    end
 
    def royal_flush?
        hand_suit=@cards[0].suit
        rf_values=[10,:J,:Q,:K,:A]

        return false , "rf" if !@cards.all?{|card| card.suit==hand_suit}
        return false , "rf" if !@cards.all?{|card| rf_values.include?(card.value)}
        return true, "rf"
    end

    def straight_flush?
        hand_suit=@cards[0].suit
        return false, "sf" if !@cards.all?{|card| card.suit==hand_suit}

        sf_values=@cards.map{|card| Deck::VALUES.index(card.value)}.sort!

        sf_order_check=(0...sf_values.length-1).collect.with_index do |deck_i,i| 
            sf_values[deck_i]+1==sf_values[(i+1)%13]
        end

        if sf_order_check.all? {|el| el==true}
            return true ,"sf"
        else
            return false , "sf"
        end
    end

    def flush?
        hand_suit=@cards[0].suit
        if @cards.all?{|card| card.suit==hand_suit}
            return true, "fl"
        else
            return false , "fl"
        end
    end

    def full_house?
        return true ,"fh" if three_kind?[0] && pair?[0]
        return false , "fh"
    end

    def four_kind?
        hand_values=@cards.collect{|card| card.value}.uniq
            hand_values.each do |value|
                count=0
                @cards.each do |card|
                    if card.value==value
                        count+=1 
                        @sp_cards<<card
                    end
                end
                @sp_cards.clear if count!=4
                if count==4
                    return true ,"fk"
                end
            end
        return false , "fk"
    end

    def three_kind?
        hand_values=@cards.collect{|card| card.value}.uniq
            hand_values.each do |value|
                count=0
                @cards.each do |card|
                    if card.value==value
                        count+=1 
                        @sp_cards<<card
                    end
                end
                @sp_cards.clear if count!=3
                if count==3
                    return true , "tk"
                end
            end
        return false , "tk"
    end

    def pair?
        hand_values=@cards.collect{|card| card.value}.uniq
            hand_values.each do |value|
                count=0
                @cards.each do |card|
                    if card.value==value
                        count+=1 
                        @sp_cards<<card
                    end
                end
                @sp_cards.clear if count!=2
                if count==2
                    return true , "pa"
                end
            end
        return false, "pa"
    end

    def two_pair?
        hand_values=@cards.collect{|card| card.value}.uniq
            pairs=0
            hand_values.each do |value|
                count=0
                pair=[]
                @cards.each do |card|
                    if card.value==value
                        count+=1 
                        pair<<card
                    end
                end
                pair.clear if count!=2
                if count==2
                    pairs+=1 
                    (@sp_cards<<pair).flatten!
                end
                if pairs==2
                    return true ,"tpa"
                end
            end
        return false , "tpa"
    end

    def high_card
        if !(royal_flush?[0]&&straight_flush?[0]&&full_house?[0]&&four_kind?[0]&&three_kind?[0]&&two_pair?[0]&&pair?[0])
        hand_values=@cards.collect{|card| card.value}.uniq
        h_card=hand_values.map{|v| Deck::VALUES.index(v)}.max
        return Deck::VALUES[h_card],"hc"
        else 
            return false , "hc"
        end
    end 

    def sp_hands
        options=[
            royal_flush?,straight_flush?,flush?,
        full_house?,four_kind?,three_kind?,two_pair?,
        pair?,high_card
    ]
        options.each {|sp| return sp[1] if sp[0] || sp[0].class==Integer}  
    end

    def compare(other)

        h2 = other

        if @order.index(self.sp_hands)>@order.index(h2.sp_hands)
            return self
        elsif @order.index(self.sp_hands)<@order.index(h2.sp_hands)
            return h2
        else 
            py1_all = @cards.map{|card| Deck::VALUES.index(card.value)}.max
            py2_all = h2.cards.map{|card| Deck::VALUES.index(card.value)}.max

            py1_sp = @sp_cards.map{|card| Deck::VALUES.index(card.value)}.max
            py2_sp = h2.sp_cards.map{|card| Deck::VALUES.index(card.value)}.max

            case self.sp_hands
            when "rf"
                return "all"
            when "sf"
               return self if py1_all>py2_all
               return h2 if py1_all<py2_all
            when "fl"
                return "all"
            when "fh"
                comp1 = Hash.new(0)
                comp2 = Hash.new(0)
               @sp_cards.each {|card| comp1[card.value]+=1}
               h2.sp_cards.each {|card| comp2[card.value]+=1}
               if Deck::VALUES.index(comp1.key(3))>Deck::VALUES.index(comp2.key(3))
                return self
               else
                return h2
               end    
            when "fk"
                return self if py1_sp>py2_sp
                return h2 if py1_sp<py2_sp
            when "tk"
                return self if py1_sp>py2_sp
                return h2 if py1_sp<py2_sp
            when "tpa"
               tpa1=@sp_cards.map{|card| card.value}
               tpa2=h2.sp_cards.map{|card| card.value}

              p1= Deck::VALUES.index(tpa1[0])+Deck::VALUES.index(tpa1[1])
              p2= Deck::VALUES.index(tpa2[0])+Deck::VALUES.index(tpa2[1])

            
                return self if p1>p2
                return h2 if p1<p2
            when "pa"
                return self if py1_sp>py2_sp
                return h2 if py1_sp<py2_sp
            when "hc"
                return self if py1_all>py2_all
                return h2 if py1_all<py2_all
                hc1=@cards.map{|card| Deck::VALUES.index(card.value)}.sort!
                hc2=h2.cards.map{|card| Deck::VALUES.index(card.value)}.sort!
                hc1.pop
                hc2.pop
                return self if hc1.max>hc2.max
                return h2 if hc1.max<hc2.max
            end
        end 
    end
end