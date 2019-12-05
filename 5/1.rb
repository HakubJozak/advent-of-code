require_relative 'intcode_computer'
require_relative 'test_helper'


# identity
# IntcodeComputer.new( [ 3,0,4,0,99 ]).run([33]) 


# IntcodeComputer.new( [ 1002,4,3,4,33 ]).run() do
#   puts output  
# end



# IntcodeComputer.new( [ 1002,4,3,4,33 ]).run
assert_computation [ 2,3,0,3,99 ],  [ 2,3,0,6,99 ]
assert_computation [ 2,4,4,5,99,0 ], [2,4,4,5,99,9801 ]
assert_computation [ 1,1,1,4,99,5,6,0,99 ], [ 30,1,1,4,2,5,6,0,99 ]


