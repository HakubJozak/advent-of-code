class Computer

  attr_reader :code

  def initialize(program)
    @code = program
  end

  def start!
    @pointer = 0

    loop do
      execute
      break if @pointer >= @code.size
    rescue Stop
      # puts "STOPPED AT #{@pointer}"
      return
    end
  end

  def result
    @code[0]
  end

  Stop = Class.new(RuntimeError)
  
  private
    def execute
      case op = @code[@pointer]
      when 1
        change value(@pointer + 1) + value(@pointer + 2)
      when 2
        change value(@pointer + 1) * value(@pointer + 2)
      when 99
        raise Stop
      else
        raise "Invalid operation: #{ op }"
      end

      @pointer += 4
    end

    def value(position)
      @code[@code[position]]
    end

    def change(val)
      position = @code[@pointer + 3]
      # puts "CHANGE: code[#{position}] = #{val}"
      @code[position] = val
    end    

end


def task_1202
  code = File.read('intcode').split(',').map(&:to_i)
  code[1] = 12
  code[2] = 2
  code
end

def test1
  [ 1,0,0,0,99 ]
end

def test2
  [ 2,3,0,3,99 ]
end

def test4
  [ 1,1,1,4,99,5,6,0,99 ]
end


def find_inputs
  answer  = 19690720
  initial = File.read('intcode').split(',').map(&:to_i).freeze

  (0..99).each do |noun|
    (0..99).each do |verb|
      code = initial.dup
      code[1] = noun
      code[2] = verb
      computer = Computer.new(code)
      computer.start!

      if computer.result == answer
        puts 'HIT!'
        puts noun
        puts verb
      else
        computer
      end
    end
  end
end



# c = Computer.new(task_1202)
# c.start!
# puts c.code.map(&:to_s).join(',')


find_inputs
