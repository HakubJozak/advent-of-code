
task_input = File.new('input.txt').read.lines
# puts orbits

test_input_santa = 'COM)B
B)C
C)D
D)E
E)F
B)G
G)H
D)I
E)J
J)K
K)L
K)YOU
I)SAN'.lines

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
  attr_reader :planets, :name
  attr_accessor :sun

  def initialize(name)
    @name = name
    @planets = []
  end

  def santa?
    @name == 'SAN'
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

  def transfers_to_santa
    you = @index['YOU']
    santa = @index['SAN']    

    a = path_to_COM(you)
    b = path_to_COM(santa)

    while a.shift == b.shift
    end

    puts a.inspect
    puts b.inspect

    a.size + b.size + 2
  end

  def path_to_COM(planet)
    path = []

    while planet.sun
      path.unshift planet.sun
      planet = planet.sun
    end

    path.map(&:name)
  end
  
  def build!
    @map.each do |expr|
      s,p = expr.strip.split(')')
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

puts OrbitMap.new(test_input_santa).transfers_to_santa
puts OrbitMap.new(task_input).transfers_to_santa
