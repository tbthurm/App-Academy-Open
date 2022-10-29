require "game"
require "deck"
require "player"
require "card"
require "hand"

describe 'Game' do 
    subject(:game) {Game.new(["A","B","C","D"])}

    describe "#initialize" do 
        it "has a deck instance" do 
            expect(game.deck).to be_instance_of(Deck)
        end

        it "has instance variable of players" do
            expect(game.players[0]).to be_instance_of(Player) 
        end
        
        it "has instance variable of pot" do
            expect(game.g_pot).to eq(0)
        end

        it "has variable for current player" do
            expect(game.current_player).to eq(game.players[0])
        end

        it "has a winner instance variable" do 
            expect(game.winner).to eq([])
        end
    end

    describe "#switch" do
        before do 
            game.players=[Player.new("A"),
                        Player.new("B"),
                        Player.new("C"),
                        Player.new("D")]

            game.current_player=game.players[0]
            game.switch
        end

        it "should switch players" do
            expect(game.current_player).to eq(game.players[1])
        end
    end

    describe "#deal" do
        it "passes 5 cards each to players" do 
            game.deal
            expect(game.players[0].hand.length).to eq(5)
        end
    end

    describe "#ante" do 
        it "takes small enter bet" do
            val=game.players[0].pot.dup
            game.ante
            expect(game.players[0]).not_to eq(val)
        end 
    end

    describe "#bet_round" do 
        it "calls player#choose" do 
        allow(game).to receive(:choose)
        expect(game).to receive(:choose)
        game.bet_round
        end

        
    end

    describe "#discard_round" do 
        it "calls player#choose" do 
        allow(game).to receive(:discard)
        expect(game).to receive(:discard)
        game.discard_round
        end
    end

    describe "#round_play" do 
        it "calls bet_round and discard_round" do 
            allow(game).to receive(:discard_round)
            allow(game).to receive(:bet_round)
        end
    end
            

    describe "#play" do 
        it "starts with ante and deal" do
            expect(game.play).to receive(:ante)
            expect(game.play).to receive(:deal)
        end
        it "calls switch" do 
            expect(game.play).to receive(:switch)
        end
    end

end