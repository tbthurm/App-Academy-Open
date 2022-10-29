require "card"

describe "Card" do 
    subject(:card) {Card.new(:H,:A)}

    describe "#initialize" do 
        it "accepts two args :suit and value" do
            Card.new(:H,:A)
        end

        it "sets value to instance variable" do 
            expect(card.value).to eq(:A)
        end

        it "sets suit to instance variable" do 
            expect(card.suit).to eq(:H)
        end
    end

    describe "#to_s" do
        it "prints array of suit,value" do
            expect(card.to_s).to eq([card.suit,card.value])
        end
    end
end