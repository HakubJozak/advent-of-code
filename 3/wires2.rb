require 'set'

class Wire

  def initialize(definition = nil)
    super()
    @coords  = [0,0]
    @mileage = 0
    @path    = {}

    definition.split(',').each do |instruction|
      read(instruction)
    end
  end

  def path
    @path.keys
  end

  def length_for(point)
    @path.fetch(point)
  end
  
  def crossings(other)
    path & other.path
  end

  private
    def read(instruction)
      direction = instruction[0]
      distance  = instruction[1..-1].to_i

      case direction
      when 'U'
        distance.times { move(0,1) }
      when 'D'
        distance.times { move(0,-1) }
      when 'L'
        distance.times { move(-1,0) }
      when 'R'
        distance.times { move(1,0) }
      else raise "Invalid direction #{direction}"
      end
    end

    def move(x,y)
      @coords[0] += x
      @coords[1] += y
      @mileage += 1
      @path[@coords.dup] = @mileage
    end
end



da, db = File.new('wires.txt').read.lines
a = Wire.new(da)
b = Wire.new(db)

crossings = a.crossings(b)

puts "Crossings: #{ crossings }"
best = crossings.map do |crossing|
  a.length_for(crossing) + b.length_for(crossing)
end.min

puts "Best: #{ best.inspect } steps"
