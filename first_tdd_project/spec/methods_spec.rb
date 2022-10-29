require 'methods'

describe "Array" do
    describe "#my_uniq" do
        it "should remove duplicates" do 
            expect([1,2,3,4,4,3,2,1].my_uniq).to eq([1,2,3,4])
        end
    end

    describe "#two_sum" do 
        it "should raise error if array is not numbers" do 
            expect(["a", "b", "c", "d"].two_sum).to eq([])
        end

        it "should return indices that sum to zero" do 
            expect([-1, 0, 2, -2, 1].two_sum).to eq([[0,4],[2,3]])
        end

        it "should start from smallest sets first" do 
            expect([2,-1,1,-2,-2].two_sum).to_not eq([[1,2],[0,4],[0,3]])
            expect([2,-1,1,-2,-2].two_sum).to eq([[0,3],[0,4],[1,2]])
        end

        it "should be uniq pairs" do
            expect([2,-1,1,-2,-2].two_sum).to_not eq([[1,2],[0,4],[0,3],[2,1][3,0],[4,0]])
        end
    end

    describe "#my_transpose" do
        it "returns a two_dimensional array" do 
            expect([[0,1,2],[3,4,5],[6,7,8]].my_transpose.all?{|sub| sub.class==(Array)}).to eq(true)
        end
        it "flips rows and columns" do 
            expect([[0,1,2],[3,4,5],[6,7,8]].my_transpose).to eq([[0,3,6],[1,4,7],[2,5,8]])
        end
    end

    describe "#stock_picker" do 
        let(:good_stock) {[10,5,15,40,33,50,20,80]}
        let(:bad_stock) {[10,5,4,3,2,1]}

        it "returns best days to buy and sell" do 
            expect(good_stock.stock_picker).to eq([1,7])
        end
        
        it "returns nothing" do 
            expect(bad_stock.stock_picker).to be_nil
        end
    end

end