require_relative 'intcode_computer'
require_relative 'test_helper'


# Using position mode, consider whether the input is equal to 8; output 1 (if it is) or 0 (if it is not).
# with_program [ 3,9,8,9,10,9,4,9,99,-1,8 ] do |computer|
#   assert_outputs  [ 0 ], computer.run([ 1 ])
#   assert_outputs  [ 1 ], computer.run([ 8 ])
# end


# Using position mode, consider whether the input is less than 8; output 1 (if it is) or 0 (if it is not).
# with_program [ 3,9,7,9,10,9,4,9,99,-1,8 ] do |computer|
#   assert_outputs  [ 0 ], computer.run([ 333 ])
#   assert_outputs  [ 1 ], computer.run([ -8 ])
# end


# assert_computation [ 3,3,1108,-1,8,3,4,3,99 ], [ 8 ], [ 1 ]
# assert_computation [ 3,3,1108,-1,8,3,4,3,99 ], [ 3948 ], [ 0 ]
# assert_computation [ 3,3,1108,-1,8,3,4,3,99 ], [ 3948 ], [ 0 ]
# assert_computation [ 3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9 ], [ 0 ], [0]


assert_computation [ 3,3,1105,-1,9,1101,0,0,12,4,12,99, 1 ], [0], [0]

#      3,3,1108,-1,8,3,4,3,99 - Using immediate mode, consider whether the input is equal to 8; output 1 (if it is) or 0 (if it is not).
#     3,3,1107,-1,8,3,4,3,99 - Using immediate mode, consider whether the input is less than 8; output 1 (if it is) or 0 (if it is not).
# Here are some jump tests that take an input, then output 0 if the input was zero or 1 if the input was non-zero:
#     3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9 (using position mode)
#     3,3,1105,-1,9,1101,0,0,12,4,12,99,1 (using immediate mode)


diagnostics = File.new('input.txt').read.split(',').map(&:to_i)
IntcodeComputer.new( diagnostics ).run([ 5 ])

