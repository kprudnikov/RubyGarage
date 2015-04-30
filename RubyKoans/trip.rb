def number_of_triplets(ar)
  ar.sort!
  score = 0
  count = 1
  ar.each.with_index do|el, index|
    if(!index)
      next
    end
    # count += 1
    if el == ar[index-1]
      count += 1
      # puts count
    else
      count = 1
    end

    if count == 3
      score += el*100
      count = 1
    end
  end

  score
end

def score(dice)
  score = 0
  ones = dice.find_all{|i| i == 1}
  fives = dice.find_all{|i| i == 5}
  score += (ones.size % 3)*100 if ones.size
  score += ones.size.divmod(3)[0] *1000 if ones.size
  score += (fives.size % 3)*50 if fives.size
  score += fives.size.divmod(3)[0] * 500 if fives.size

  leftover = dice - ones
  leftover = leftover - fives

  score += number_of_triplets(leftover)
  score
end

# puts number_of_triplets([1,2,3])
# puts number_of_triplets([1,2,3,4,5,1,2,3,1,2,3])
  # puts "Ones" + score.to_s
puts score([1,1,1,5,1])
# puts score([2,3,4,6,2])
# puts score([3,4,5,3,3])
# puts score([1,5,1,2,4])