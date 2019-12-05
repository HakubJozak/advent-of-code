require_relative 'intcode_computer'


identity = [ 3,0,4,0,99 ]
computer = IntcodeComputer.new(identity)

computer.run([42]) do |output|
  puts output
end
