require_relative 'enumerable'

puts 'each:::::::::::::::'
[1, 2, 3].each do |item|
  puts item + 10
end
p [1, 2, 3].each

puts 'my_each::::::::::::::::'
[1, 2, 3].my_each do |item|
  puts item + 10
end
[1, 2, 3].my_each

puts 'each_with_index:::::::::::::::'
[1, 2, 3].each_with_index do |item, index|
  print index, item
  puts "\n"
end
p [1, 2, 3].each_with_index

puts 'my_each_with_index:::::::::::::::'
[1, 2, 3].my_each_with_index do |item, index|
  print index, item
  puts "\n"
end
p [1, 2, 3].my_each_with_index

puts 'select::::::::::::::::'
p [1, 2, 3, 4, 5].select(&:even?)
p [1, 2, 3, 4, 5].select

puts 'my_select:::::::::::::'
p [1, 2, 3, 4, 5].my_select(&:even?)
p [1, 2, 3, 4, 5].my_select

puts 'all?::::::::::::::::::::'
puts %w[ant bear cat].all? { |word| word.length >= 3 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts %w[ant bear cat].all? { |word| word.length >= 4 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts 'all?:::Regex:::::::::::::::::'
puts %w[ant bear cat].all?(/t/)
puts %w[ant beat cat].all?(/t/)
puts %w[ant beat cat].all?('*')
puts %w[ant beat cat].all?('beat')
puts %w[beat beat beat].all?('beat')
puts %w[ant beat cat].all?('BOOM/')
puts [1, 2i, 3.14].all?(Numeric)
puts %w[ant bear cat].all?(String)
puts [nil, true, 99].all?
puts [1, true, 99].all?
puts [].all?

puts 'my_all?::::::::::::::::::::'
puts %w[ant bear cat].my_all? { |word| word.length >= 3 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts %w[ant bear cat].my_all? { |word| word.length >= 4 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts 'my_all?:::Regex:::::::::::::::::'
puts %w[ant bear cat].my_all?(/t/)
puts %w[ant beat cat].my_all?(/t/)
puts %w[ant beat cat].my_all?('*')
puts %w[ant beat cat].my_all?('beat')
puts %w[beat beat beat].my_all?('beat')
puts %w[ant beat cat].my_all?('BOOM/')
puts [1, 2i, 3.14].my_all?(Numeric)
puts %w[ant bear cat].my_all?(String)
puts [nil, true, 99].my_all?
puts [1, true, 99].my_all?
puts [].my_all?

puts 'any?::::::::::::::::::::'
puts %w[ant bear cat].any? { |word| word.length >= 3 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts %w[ant bear cat].any? { |word| word.length >= 4 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts %w[ant bear cat].any?(/d/)
puts [nil, true, 99].any?(Integer)
puts [nil, true, 99].any?
puts [].any?
puts %w[ant beat cat].any?('*')
puts %w[ant beat cat].any?('beat')
puts %w[beat beat beat].any?('beat')
puts %w[ant beat cat].any?('BOOM/')
puts [1, 2i, 3.14].any?(Numeric)
puts %w[ant bear cat].any?(String)

puts 'my_any?:::::::::::::::::::'
puts %w[ant bear cat].my_any? { |word| word.length >= 3 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts %w[ant bear cat].my_any? { |word| word.length >= 4 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts %w[ant bear cat].my_any?(/d/)
puts [nil, true, 99].my_any?(Integer)
puts [nil, true, 99].my_any?
puts [].my_any?
puts %w[ant beat cat].my_any?('*')
puts %w[ant beat cat].my_any?('beat')
puts %w[beat beat beat].any?('beat')
puts %w[ant beat cat].my_any?('BOOM/')
puts [1, 2i, 3.14].my_any?(Numeric)
puts %w[ant bear cat].my_any?(String)

puts 'none?::::::::::::::::::::::::::::::::'
puts %w[ant bear cat].none? { |word| word.length == 5 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts %w[ant bear cat].none? { |word| word.length >= 4 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts %w[ant bear cat].none?(/d/)
puts [1, 3.14, 42].none?(Float)
puts [].none?
puts [nil].none?
puts [nil, false].none?
puts [nil, false, true].none?
puts %w[ant beat cat].none?('*')
puts %w[ant beat cat].none?('beat')
puts %w[beat beat beat].none?('beat')
puts %w[ant beat cat].none?('BOOM/')
puts [1, 2i, 3.14].none?(Numeric)
puts %w[ant bear cat].none?(String)

puts 'my_none?::::::::::::::::::::::::::::::::'
puts %w[ant bear cat].my_none? { |word| word.length == 5 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts %w[ant bear cat].my_none? { |word| word.length >= 4 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts %w[ant bear cat].my_none?(/d/)
puts [1, 3.14, 42].my_none?(Float)
puts [].my_none?
puts [nil].my_none?
puts [nil, false].my_none?
puts [nil, false, true].my_none?
puts %w[ant beat cat].my_none?('*')
puts %w[ant beat cat].my_none?('beat')
puts %w[beat beat beat].my_none?('beat')
puts %w[ant beat cat].my_none?('BOOM/')
puts [1, 2i, 3.14].my_none?(Numeric)
puts %w[ant bear cat].my_none?(String)

puts 'count::::::::::::::'
result_count = [1, 2, 4, 2].count(&:even?)
p result_count
p [1, 2, 4, 2].count
p [1, 2, 4, 2].count(2)
puts %w[ant bear cat].count('cat')

puts 'my_count::::::::::::::'
my_result_count = [1, 2, 4, 2].my_count(&:even?)
p my_result_count
p [1, 2, 4, 2].my_count
p [1, 2, 4, 2].my_count(2)
puts %w[ant bear cat].my_count('cat')

puts 'map:::::::::::::::::::::::::'
p(1..4).map { |i| i * i } # rubocop:todo Lint/AmbiguousBlockAssociation
p (1..4).map

puts 'my_map:::::::::::::::::::::::::'
p(1..4).my_map { |i| i * i } # rubocop:todo Lint/AmbiguousBlockAssociation
p (1..4).my_map

puts 'my_map_accepts_proc:::::::::::::::::::::::::'
proc = proc do |i|
  i * i
end
block = proc do |i|
  i * i
end
p (1..4).map(&proc)
p (1..4).my_map(&proc)
p (1..4).my_map_accepts_proc proc

puts 'my_map_accepts_proc_and_block when a proc is passed:::::::::::::::::::::::::'
p (1..4).my_map_accepts_proc_and_block proc, &block

puts 'my_map_accepts_proc_and_block when a block is passed:::::::::::::::::::::::::'
p (1..4).my_map_accepts_proc_and_block nil, &block

puts 'inject:::::::::::::'
puts (5..10).inject(:+)
inject_result = (5..10).inject(1) { |product, n| product * n }
puts inject_result
inject_result = (5..10).inject { |product, n| product * n }
puts inject_result

puts 'my_inject:::::::::::::'
puts (5..10).my_inject(:+)
puts (5..10).my_inject(:*)
puts (5..10).my_inject(1, :*)
my_inject_result = (5..10).my_inject(1) { |product, n| product * n }
puts my_inject_result
my_inject_result = (5..10).my_inject { |product, n| product * n }
puts my_inject_result
p (5..10).my_inject

puts 'multiply_els::::::::::::::::::::::::::::::::::::::'

def multiply_els(array)
  array.my_inject(1) { |product, n| product * n }
end
puts multiply_els([2, 4, 5])
