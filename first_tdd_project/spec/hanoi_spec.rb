require "hanoi"

describe "Hanoi" do 
    subject(:game) {Hanoi.new}

    describe "#initialize" do 
        it "sets 2d array for piles" do 
            expect(game.piles.all?{|pile| pile.class==Array}).to eq(true)
        end

        it "starts by rules" do 
            expect(game.piles).to eq([[1,2,3,4],[],[]])
        end
    end

    describe "#move_disc" do 
        context "accepts two numbers as arguments" do
            it "1st position and 2nd position" do 
                expect {game.move_disc(0,2)}.to_not raise_error(ArgumentError)
            end

            it "neither number should be larger than game" do 
                expect {game.move_disc(3,3)}.to raise_error(ArgumentError)
            end

            it "should place small onto large" do
                game.move_disc(0,1)
                expect(game.piles).to eq([[2,3,4],[1],[]])
            end

            it "should not place small onto large" do 
                game.piles=[[2,3,4],[1],[]]
                expect {game.move_disc(0,1)}.to raise_error(ArgumentError)
            end
        end
    end

    describe "#won?" do 
        let(:won) {Hanoi.new}
        it "returns true if last pile equals [1,2,3,4]" do
            won.piles=[[],[],[1,2,3,4]]
            expect(won.won?).to eq(true)
        end

        it "returns false if last pile is not [1,2,3,4]" do 
            expect(game.won?).to eq(false)
        end
    end
end