require "deck"

describe "Deck" do 
    subject(:deck) {Deck.new}
    describe "#initialize" do 
        it "fills a cards array" do
            expect(deck.cards.length).to eq(52)
        end
    end

    describe "#fill" do 
        it "fills @cards with 52 cards" do
            expect(deck.fill).to eq(true)
        end
    end

    describe "#shuffle_cards" do 
    let(:tes) {Deck.new}
        it "shuffles @cards" do 
            expect(tes.cards).not_to eq(deck.shuffle_cards)
        end
    end

end