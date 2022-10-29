require "hand"
require "card"

describe "Hand" do

    let(:draw) {[
        double('H10',suit: :H,value:10),
        double('SK',suit: :S,value: :K),
        double('D2',suit: :D,value:2),
        double('C5',suit: :C,value:5),
        double('HA',suit: :H,value: :A)
    ]}

    subject(:hand) {Hand.new(draw)}    

    describe "#initialize" do 
        it "hand accepts cards arg" do 
            expect(hand.cards).to eq(draw)
        end

        it "hand is only 5 cards" do 
            expect(hand.cards.length).to eq(5)
        end

        it "has an empty array of special cards" do
            expect(hand.sp_cards).to be_empty
        end
    end

    describe "#royal_flush?" do 
        context 'Hand is royal flush.' do
        before do
            hand.cards = [
            double('S10',suit: :S,value:10),
            double('SJ',suit: :S,value: :J),
            double('SQ',suit: :S,value: :Q),
            double('SK',suit: :S,value: :K),
            double('SA',suit: :S,value: :A)
        ]
        end

        it "returns true if hand is a royal flush" do
            expect(hand.royal_flush?[0]).to be_truthy
        end
        end

        it "returns false if hand is a not royal flush" do
            expect(hand.royal_flush?[0]).not_to be_truthy
        end
    end

    describe "#straight_flush?" do
        context 'Hand is straight flush.' do
        before do 
            hand.cards=[
            double('H10',suit: :H,value:10),
            double('H9',suit: :H,value:9),
            double('H8',suit: :H,value:8),
            double('H7',suit: :H,value:7),
            double('H6',suit: :H,value:6)
        ]
        end

        it "returns true if hand is a straight flush" do
            expect(hand.straight_flush?[0]).to be_truthy
        end
        end

        it "returns false if hand is a not straight flush" do
            expect(hand.straight_flush?[0]).not_to be_truthy
        end

    end

    describe "#flush?" do 
        context 'Hand is flush.' do
        before do 
            hand.cards = [
            double('S5', suit: :S,value:5),
            double('S9', suit: :S,value:9),
            double('SJ', suit: :S,value: :J),
            double('SQ', suit: :S,value: :Q),
            double('S6', suit: :S,value:6)
            ]
        end

        it "returns true if hand is a flush" do
            expect(hand.flush?[0]).to be_truthy
        end
        end

        it "returns false if hand is not a flush" do
            expect(hand.flush?[0]).not_to be_truthy
        end 
    end

    describe "#full_house?" do 
        context 'Full house hand.' do
        before do 
            hand.cards[2] = double('D10',suit: :D,value:10)
            hand.cards[3] = double('C10',suit: :C,value:10)
            hand.cards[4] = double('HK',suit: :H,value: :K)
        end

        it "returns true if hand is a full house" do
            expect(hand.full_house?[0]).to be_truthy
        end 
        end

        it "returns false if hand is not a full house" do
            expect(hand.full_house?[0]).not_to be_truthy
        end 
    end

    describe "#four_kind?" do
        context 'Four of a kind hand.' do 
        before do 
            hand.cards[0]= double('H2',suit: :H,value:2)
            hand.cards[1]= double('S2',suit: :S,value:2)
            hand.cards[3]= double('C2',suit: :C,value:2)
        end

        it "returns true if hand is a four_kind" do
            expect(hand.four_kind?[0]).to be_truthy
        end 
        end

        it "returns false if hand is not a four_kind" do
            expect(hand.four_kind?[0]).not_to be_truthy
        end
    end

    describe "#three_kind?" do
        context 'Three of a kind hand.' do 
        before do 
            hand.cards[0]= double('HK',suit: :H,value: :K)
            hand.cards[2]= double('DK',suit: :D,value: :K)
        end

        it "returns true if hand is a three_kind" do
            expect(hand.three_kind?[0]).to be_truthy
        end 
        end

        it "returns false if hand is not a three_kind" do
            expect(hand.three_kind?[0]).not_to be_truthy
        end      
    end

    describe "#two_pair?" do
        context 'Two pairs in hand.' do 
        before do 
            hand.cards[0]= double('DA',suit: :D,value: :A)
            hand.cards[1]= double('D5',suit: :D,value:5)
        end
    
        it "returns true if hand is a two_pair" do
            expect(hand.two_pair?[0]).to be_truthy
        end 
        end

        it "returns false if hand is not a two_pair" do
            expect(hand.two_pair?[0]).not_to be_truthy
        end
    end

    describe "#pair?" do
        context 'Any pair in hand.' do 
        before do 
            hand.cards[1]= double('D10',suit: :D,value:10)
        end

        it "returns true if hand is a pair" do
            expect(hand.pair?[0]).to be_truthy
        end 
        end

        it "returns false if hand is not a pair" do
            expect(hand.pair?[0]).not_to be_truthy
        end
    end

    describe "#high_card" do
        context 'hand contains no special sets.' do
            it 'Shows highest card value' do
                expect(hand.high_card).to eq([:A,"hc"])
            end
        end
    end

    describe "#sp_hands" do 
        context "a list of special hands" do
            before do 
                hand.cards=[
                    double('S5', suit: :S,value:5),
                double('D5', suit: :D,value:5),
                double('SJ', suit: :S,value: :J),
                double('DJ', suit: :D,value: :J),
                double('HJ', suit: :H,value: :J)
                ]
            end
            it "returns the characters for the special hand if true" do
                expect(hand.sp_hands).to eq("fh")
            end
        end
    end

    describe "#compare" do 
        let(:h2) {Hand.new([
            double('D5',suit: :D,value:5),
            double('CJ',suit: :C,value: :J),
            double('DJ',suit: :D,value: :J),
            double('H8',suit: :H,value:8),
            double('CA',suit: :C,value: :A)
        ])}
        it "accepts a hand instance as arg" do 
            allow(hand).to receive(:compare).with(h2)
            expect(h2).to be_instance_of(Hand)
        end 
        it "returns the winner of hands" do 
            allow(hand).to receive(:compare).with(h2).and_return(h2)
        end
    end
end