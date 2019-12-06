class IntcodeComputer

  attr_reader :code, :output
  attr_accessor :debugging

  def initialize(program)
    @code = program
    @debugging = false
  end

  def run(input = [], &block)
    @output  = []
    @pointer = 0
    @input   = input

    loop do
      execute &block
      break if @pointer >= @code.size
    rescue Stop
      # puts "STOPPED AT #{@pointer}"
      break
    end

    self
  end

  def result
    @code[0]
  end

  Stop = Class.new(RuntimeError)

  private
    def execute
      #  % 100
      # opcode = @code[@pointer]
    encoded   = '%05d' % @code[@pointer]
    @operation = encoded[-2..-1].to_i
    @modes     = encoded[0..-3].reverse

    debug state
    debug "--------------------------------------------------"

    case @operation
    when 1
      # add
      write 2, read(0) + read(1)
      @pointer += 4
    when 2
      # multiply
      write 2, read(0) * read(1)
      @pointer += 4
    when 3
      # input
      write 0, @input.shift
      @pointer += 2
    when 4
      # output
      value = read(0)
      puts "Output: #{ value }"
      @output << value
      @pointer += 2
    when 5
      # jump-if-true
      if read(0).zero?
        @pointer += 3
      else
        @pointer = read(1)
      end
    when 6
      # jump-if-false
      if read(0).zero?        
        @pointer = read(1)
      else
        @pointer += 3
      end
    when 7
      # less-than
      if read(0) < read(1)
        write(2, 1)
      else
        write(2, 0)          
      end

      @pointer += 4
    when 8
      # equals
      if read(0) == read(1)
        write(2, 1)
      else
        write(2, 0)          
      end        

      @pointer += 4
    when 99
      raise Stop
    else
      raise "Invalid operation: #{ @operation } - #{@code.inspect}"
    end
    end

    def write(i, value)
      mode = @modes[i]
      raise "Invalid write mode #{mode}" unless mode == '0'
      @code[@code[ @pointer + 1 + i ]] = value
    end

    def read(i)
      mode = @modes[i]

      if mode == '0'
        # position mode
        @code[@code[ @pointer + 1 + i ]]
      elsif mode == '1'
        # immediate mode
        @code[ @pointer + 1 + i ]
      else
        raise "Invalid read mode #{ mode }"
      end
    end

    def debug(msg)
      return unless @debugging
      puts "DEBUG: #{msg}"
    end

    def state
      # info = "pointer: #{ @pointer }, operation: #{ @operation }"
      formatted = @code.map.with_index do |c,i|
        if i == @pointer
          "* %3d" % c
        else
          "%3d" % c 
        end
      end.join(" | ")

      formatted
    end

end
