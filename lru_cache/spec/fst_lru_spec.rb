require 'rspec'
require 'fst_lru'

describe LRUCache do 
    subject (:johnny_cache) {LRUCache.new(4)}

    describe "#initialize" do 
        it "sets size as a inst-variable" do 
            expect(johnny_cache.size).to eq(4)
        end

        it "sets an empty cache inst_variable" do
            expect(johnny_cache.cache).to eq([])
        end
    end

    describe "#count" do 
        before do 
            johnny_cache.cache.push(1,2,3)
        end
        it "returns count of cache" do 
            expect(johnny_cache.count).to eq(3)
        end
    end

    describe "#add" do 
        it "adds elements to cache" do
            expect(johnny_cache.count).to eq(0)
            johnny_cache.add(1)
            expect(johnny_cache.count).to eq(1)
        end

        it "keeps the cache at size" do 
            johnny_cache.add(1)
            johnny_cache.add(2)
            johnny_cache.add(3)
            johnny_cache.add(4)
            johnny_cache.add(5)
            expect(johnny_cache.count).to eq(4)
        end

        it "the oldest value if size is full when adding" do 
            johnny_cache.add(1)
            johnny_cache.add(2)
            johnny_cache.add(3)
            johnny_cache.add(4)
            johnny_cache.add(5)
            expect(johnny_cache.cache.include?(1)).to be_falsy
        end
    end

    describe "#show" do 
        it "returns the cache" do 
            johnny_cache.add(1)
            johnny_cache.add(2)
            johnny_cache.add(3)
            johnny_cache.add(4)
            johnny_cache.add(5)
            expect(johnny_cache.show).to eq(johnny_cache.cache)
        end
    end
end