def first_part
  sum = 0

  File.read('modules.txt').each_line do |line|
    sum += (line.to_i / 3) - 2
  end

  sum
end


def compute_fuel(mass)
  fuel = (mass / 3) - 2

  if fuel > 0
    fuel + compute_fuel(fuel)
  else
    0
  end
end

def second_part
  sum = 0

  File.read('modules.txt').each_line do |line|
    sum += compute_fuel(line.to_i)
  end

  sum
end


puts second_part
