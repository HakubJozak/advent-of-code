require 'set'

    # R75,D30,R83,U83,L12,D49,R71,U7,L72
    # U62,R66,U55,R34,D71,R55,D58,R83 = distance 159
    # R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51
    # U98,R91,D20,R16,D67,R40,U7,R15,U6,R7 = distance 135



class Wire

  attr_reader :path

  def initialize(definition = nil)
    super()
    @coords = [0,0]
    @path = Set.new

    definition.split(',').each do |instruction|
      read(instruction)
    end
  end

  def crossings(other)
    path.intersection(other.path)
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
      @path.add(@coords.dup)
    end
end


    
    # U62,R66,U55,R34,D71,R55,D58,R83 = distance 159
  
a = Wire.new 'R75,D30,R83,U83,L12,D49,R71,U7,L72'
b = Wire.new 'U62,R66,U55,R34,D71,R55,D58,R83'

puts "Crossings: #{ a.crossings(b) }"
puts a.crossings(b).map { |p| p[0].abs + p[1].abs }.min

