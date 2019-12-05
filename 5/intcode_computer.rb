class IntcodeComputer

  attr_reader :code

  def initialize(program)
    @code = program
  end

  def run(input = [], &block)
    @pointer = 0
    @input = input

    loop do
      execute &block
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
      # '%05d' % 100
      # opcode = @code[@pointer]
      op = @code[@pointer]

      case op 
      when 1
        # add
        val = value(@pointer + 1) + value(@pointer + 2)
        position = @code[@pointer + 3]
        @code[position] = val
        @pointer += 4
      when 2
        # multiply
        val = value(@pointer + 1) * value(@pointer + 2)
        position = @code[@pointer + 3]
        @code[position] = val
        @pointer += 4
      when 3
        # input
        position = @code[@pointer + 1]        
        @code[position] = @input.shift
        @pointer += 2
      when 4
        # output
        yield value(@pointer + 1)
        @pointer += 2
      when 99
        raise Stop
      else
        raise "Invalid operation: #{ op }"
      end


    end

    def value(position)
      @code[@code[position]]
    end

    def change(val)

      # puts "CHANGE: code[#{position}] = #{val}"

    end

end



