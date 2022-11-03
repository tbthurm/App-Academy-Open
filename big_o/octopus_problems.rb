# Big O-ctopus and Biggest Fish

# A Very Hungry Octopus wants to eat the longest fish 
# in an array of fish.

fish=['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 
'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
# => "fiiiissshhhhhh"
###########################

# Sluggish Octopus
# Find the longest fish in O(n^2) time. Do this by 
# comparing all fish lengths to all other fish lengths
def sluggish_oct(arr)
    long=nil
    (0...arr.length).each do |i1|
        (1...arr.length).each do |i2|
            arr[i1].size < arr[i2].size ? long = arr[i2] : long = arr[i1]
        end
    end
    long 
end

p sluggish_oct(fish)
#########################

# Dominant Octopus
# Find the longest fish in O(n log n) time. Hint: You 
# saw a sorting algorithm that runs in O(n log n) in the 
# Sorting Complexity Demo. Remember that Big O is 
# classified by the dominant term.
def dominant_oct(arr)
    return merge_sort(arr).last
end

def merge_sort(arr)
    return arr if arr.length<=1

    mid = arr.length / 2 

    merge(merge_sort(arr.take(mid)), merge_sort(arr.drop(mid)))
end

def merge(left,right)
    merged=[]

    until left.empty? || right.empty?
        ans= left.first.length <=> right.first.length
        case ans
        when -1 
            merged<<left.shift
        when 0
            merged<<left.shift
        when 1 
            merged<<right.shift
        end
    end
    merged + left + right
end

p dominant_oct(fish)
############################

# Clever Octopus
# Find the longest fish in O(n) time. The octopus can 
# hold on to the longest fish that you have found so 
# far while stepping through the array only once.
def clever_oct(arr)
    long=""
    arr.each {|word| long = word if word.size > long.size}
    long
end
p clever_oct(fish)
##############################

# Dancing Octopus
# Full of fish, the Octopus attempts Dance Dance 
# Revolution. The game has tiles in the following 
# directions:

tiles_array = ["up", "right-up", "right", "right-down", 
    "down", "left-down", "left",  "left-up" ]

# To play the game, the octopus must step on a tile 
# with her corresponding tentacle. We can assume 
# that the octopus's eight tentacles are numbered and 
# correspond to the tile direction indices.

# Slow Dance
# Given a tile direction, iterate through a tiles array 
# to return the tentacle number (tile index) the octopus 
# must move. This should take O(n) time.
def slow_dance(dir,arr)
    arr.each.with_index {|el,i| return i if el == dir}
end

p slow_dance("up", tiles_array)
# > 0

p slow_dance("right-down", tiles_array)
# > 3
###############################

# Constant Dance!
# Now that the octopus is warmed up, let's help her dance 
# faster. Use a different data structure and write a 
# new function so that you can access the tentacle number 
# in O(1) time.
tiles_hash = {"up"=>0, "right-up"=>1, "right"=>2, "right-down"=>3, 
    "down"=>4, "left-down"=>5, "left"=>6, "left-up"=>7}

def fast_dance(dir,hash)
    return hash[dir]
end

p fast_dance("up", tiles_hash)
# > 0

p fast_dance("right-down", tiles_hash)
# > 3