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
