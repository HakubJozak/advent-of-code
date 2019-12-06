require_relative 'intcode_computer'


def assert_equal(expected,actual)
  if expected == actual
    puts 'OK'
  else
    puts "Failed: Expected #{expected} != #{actual}"
  end
end


def assert_computation(source_code,after)
  c = IntcodeComputer.new(source_code)
  c.run
  assert_equal after, c.code
end

def assert_outputs(expected,computer)
  assert_equal expected, computer.output
end

def assert_computation(code, input, expected)
  c = IntcodeComputer.new(code).run(input)
  assert_equal expected, c.output
end

def with_program(code) 
  yield IntcodeComputer.new(code)
end
