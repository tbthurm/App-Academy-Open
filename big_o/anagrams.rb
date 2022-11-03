def first_anagram?(str1,str2)
    return false if str2.length!=str1.length
    str1.split("").permutation.to_a.map(&:join).include?(str2)
end

p first_anagram?("elvis","lives")
p first_anagram?("anamonapea","aapnaoneam")

def second_anagram?(str1,str2)
    return false if str2.length!=str1.length
    str1.each_char do |ch|
        str2.slice!(str2.index(ch)) if str2.index(ch).class==Integer
    end
    str2.empty?
end

p second_anagram?("elvis","lives")
p second_anagram?("anamonapea","aapnaoneam")

def third_anagram?(str1,str2)
    return false if str1.length!=str2.length
    str1.split("").sort==str2.split("").sort
end

p third_anagram?("elvis","lives")
p third_anagram?("anamonapea","aapnaoneam")

def fourth_anagram?(str1,str2)
    return false if str1.length!=str2.length
    hash1=Hash.new(0)
    hash2=Hash.new(0)

    str1.each_char {|ch|hash1[ch]+=1}
    str2.each_char {|ch|hash2[ch]+=1}

    hash1==hash2
end

p fourth_anagram?("elvis","lives")
p fourth_anagram?("anamonapea","aapnaoneam")

def bonus_anagram?(str1,str2)
    return false if str1.length!=str2.length
    hash=Hash.new(0)

    str1.each_char{|ch|hash[ch]+=1}
    str2.each_char{|ch|hash[ch]-=1}

    hash.values.max==0
end

p bonus_anagram?("elvis","lives")
p bonus_anagram?("anamonapea","aapnaoneam")
