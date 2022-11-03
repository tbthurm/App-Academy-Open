# my_min

# Given a list of integers find the smallest number 
# in the list.

# Example:
    list = [ 0, 3, 5, 4, -5, 10, 1, 90 ]
    # my_min(list)  # =>  -5

# Phase I
# First, write a function that compares each element 
# to every other element of the list. Return the 
# element if all other elements in the array are larger.
# What is the time complexity for this function?
def my_min(arr)
    arr.each do |num1|
        return num1 if arr.all?{|el| el>=num1}
    end
end
p my_min(list)

# Phase II
# Now rewrite the function to iterate through the list 
# just once while keeping track of the minimum. What is 
# the time complexity?
def better_min(arr)
    min=0
    arr.each {|num| min=num if num<=min}
    min
end
p better_min(list)
#######################

# Largest Contiguous Sub-sum

# You have an array of integers and you want to find the 
# largest contiguous (together in sequence) sub-sum. 
# Find the sums of all contiguous sub-arrays and return 
# the max.

# Example:
    list1 = [5, 3, -7]
    # largest_contiguous_subsum(list) # => 8

    # possible sub-sums
    # [5]           # => 5
    # [5, 3]        # => 8 --> we want this one
    # [5, 3, -7]    # => 1
    # [3]           # => 3
    # [3, -7]       # => -4
    # [-7]          # => -7

# Example 2:
    list2 = [2, 3, -6, 7, -6, 7]
    # largest_contiguous_subsum(list) # => 8 (from [7, -6, 7])
# Example 3:
    list3 = [-5, -1, -3]
    # largest_contiguous_subsum(list) # => -1 (from [-1])

# Phase I
# Write a function that iterates through the array 
# and finds all sub-arrays using nested loops. First make 
# an array to hold all sub-arrays. Then find the sums of 
# each sub-array and return the max.
# Discuss the time complexity of this solution.
def largest_contiguous_subsum(arr)
    subs = []
    arr.each.with_index do |num1,i1|
        arr[i1..-1].each.with_index do |num2,i2|
            subs<<arr[i1..i1+i2]
        end
    end
    subs.map {|sub|sub.sum}.max
end

p largest_contiguous_subsum(list1)
p largest_contiguous_subsum(list2)
p largest_contiguous_subsum(list3)
# Phase II
# Let's make a better version. Write a new function 
# using O(n) time with O(1) memory. Keep a running 
# tally of the largest sum. To accomplish this efficient 
# space complexity, consider using two variables. One 
# variable should track the largest sum so far and 
# another to track the current sum. We'll leave the rest 
# to you.
def better_lcs(arr)
    subs = []
    arr.each.with_index do |num1,i1|
        arr[i1..-1].each.with_index do |num2,i2|
            subs<<arr[i1..i1+i2]
        end
    end
    max=0
    subs.each.with_index do |sub,i|
        max=sub.sum if i==0
        max=sub.sum if max<sub.sum
    end
    max
end
p better_lcs(list1)
p better_lcs(list2)
p better_lcs(list3)
