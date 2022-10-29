require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` 
statements without blocks)! Be sure to look over the 
solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }
  subject(:pudding) {Dessert.new("pudding",100,chef)}


  describe "#initialize" do
    it "sets a type" do
      expect(pudding.type).to eq("pudding")
    end

    it "sets a quantity" do
      expect(pudding.quantity).to eq(100)
    end

    it "starts ingredients as an empty array" do
      expect(pudding.ingredients).to eq([])
    end

    it "raises an argument error when given a non-integer quantity" do
      expect {Dessert.new("cake","one",chef)}.to raise_error(ArgumentError)
    end
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
    pudding.add_ingredient("water")
    expect(pudding.ingredients).to include("water")
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      ingredients=%w(water sugar powder egg)
      ingredients.each {|item| pudding.add_ingredient(item)}
      pudding.mix!
      expect(pudding.mix!).not_to eq(pudding.ingredients.sort)
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      pudding.eat(10)
      expect(pudding.quantity).to eq(90)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect {pudding.eat(101)}.to raise_error("not enough left!")
    end
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Taste King")
      expect(pudding.serve).to eq("Taste King has made 100 puddings!")
  end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      allow(chef).to receive(:bake).with(pudding)
      pudding.make_more
  end
  end
end
