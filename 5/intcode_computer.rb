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
      #  % 100
      # opcode = @code[@pointer]
    encoded = '%05d' % @code[@pointer]
    operation = encoded[-2..-1].to_i
    modes     = encoded[1..-2]

      case operation
      when 1
        # add
        write modes, 2, read(modes, 0) + read(modes, 1)
        @pointer += 4
      when 2
        # multiply
        write modes, 2, read(modes, 0) * read(modes, 1)
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
        raise "Invalid operation: #{ operation }"
      end
    end

    def write(modes, i, value)
      mode = modes[i]
      raise 'Invalid write mode' unless mode == '0'
      @code[@code[ @pointer + 1 + i ]] = value
    end

    def read(modes, i)
      mode = modes[i]

      if mode == '0'
        # position moden
        @code[@code[ @pointer + 1 + i ]]
      elsif mode == '1'
        # immediate mode
        @code[ @pointer + 1 + i ]
      else
        raise "Invalid read mode #{ mode }"
      end
    end


end



