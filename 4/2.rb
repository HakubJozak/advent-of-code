# It is a six-digit number.
# The value is within the range given in your puzzle input.
# Two adjacent digits are the same (like 22 in 122345).
# Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).


# Your puzzle input is 134564-585159.


def valid_password?(str)
  return false unless str.size == 6

  last = nil
  had_pair = false
  counter = 1

  str.each_char do |char|
    if last == char
      # puts 'raise'
      counter += 1
    else
      # puts "ok - #{counter}"
      had_pair = true if counter == 2
      counter = 1
    end

    # invalid decrease
    if last && char.to_i < last.to_i
      return false
    end

    last = char
  end

  had_pair || counter == 2
end

def count_in_range(range)
  range.reduce(0) do |sum,x|
    sum += 1 if valid_password?(x.to_s)
    sum
  end  
end


puts valid_password?('111111')
# puts valid_password?('223450')
# puts valid_password?('123789')
puts valid_password? '111122'
# puts valid_password? '123444'





puts count_in_range(134564..585159)
