require "player"

describe 'Player' do
    let(:player){Player.new("Bill")}

    describe '#initialize' do
        it 'sets instance variable ,hand, to empty' do
            expect(player.hand).to eq([])
        end

        it 'sets instance variable ,pot, to 500' do
            expect(player.pot).to eq(500)
        end

        it "has instance variable for player folded or not" do 
            expect(player.folded).to be false
        end

        it "has instance variable for player taken turn or not" do 
            expect(player.turn).to be false
        end
    end

    describe '#discard' do
        it "prints 'which cards to discard'" do 
            allow(player).to receive(:gets).and_return("1/n")
            expect { player.discard }.to output(/which/).to_stdout
        end

        it "gets which cards to discard from player" do
           allow(player).to receive(:gets).and_return("1/n")
            expect(player).to receive(:gets)
            player.discard
        end

    end

    describe '#choose' do 
        it 'should print "choose fold,see,or raise :use f,s, or r" ' do
            allow(player).to receive(:gets).and_return("f\n")
            expect { player.choose }.to output(/fold/).to_stdout
        end

        it 'gets choice from player' do 
            allow(player).to receive(:gets).and_return("f\n")
            expect(player).to receive(:gets)
            player.choose
        end
    end

    describe "#show_hand" do 
        before do 
            player.hand = [double('D5',suit: :D,value:5),
            double('CJ',suit: :C,value: :J),
            double('DJ',suit: :D,value: :J),
            double('H8',suit: :H,value:8),
            double('CA',suit: :C,value: :A)]
        end

        it "shows player's hand" do
            expect(player.show_hand.length).to eq(5)
        end
    end

end