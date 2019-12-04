# It is a six-digit number.
# The value is within the range given in your puzzle input.
# Two adjacent digits are the same (like 22 in 122345).
# Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).


# Your puzzle input is 134564-585159.


def valid_password?(str)
  return false unless str.size == 6

  last = nil
  has_pair = false

  str.each_char do |char|
    has_pair = true if last == char

    # invalid decrease
    if last && char.to_i < last.to_i
      return false
    end

    last = char
  end

  has_pair
end


# puts valid_password?('111111')
# puts valid_password?('223450')
# puts valid_password?('123789')


total = (134564..585159).reduce(0) do |sum,x|
  sum += 1 if valid_password?(x.to_s)
  sum
end


puts total.to_s




