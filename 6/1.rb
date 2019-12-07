
task_input = File.new('input.txt').read.lines
# puts orbits

test_input_42 = 'COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L'.lines


class Planet
  attr_reader :planets
  attr_accessor :sun

  def initialize(name)
    @name = name
    @planets = []
  end
end


class OrbitMap
  def initialize(map)
    @index = {}
    @map = map
    build!
  end

  def checksum
    sum = 0

    @index.values.each do |planet|
      while planet.sun
        sum += 1
        planet = planet.sun
      end
    end

    sum
  end

  def build!
    @map.each do |expr|
      s,p = expr.chop.split(')')
      sun = find_or_create_planet(s)
      planet = find_or_create_planet(p)

      sun.planets << planet
      planet.sun = sun
    end

    @index.keys.size
  end

  def find_or_create_planet(name)
    @index[name] || (@index[name] = Planet.new(name))
  end
end

puts OrbitMap.new(test_input_42).checksum
# puts OrbitMap.new(test_input_42).checksum

