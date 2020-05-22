require_relative 'enumerable'

puts 'each:::::::::::::::'
[1, 2, 3].each do |item|
  puts item + 10
end

puts 'my_each::::::::::::::::'
[1, 2, 3].my_each do |item|
  puts item + 10
end

puts 'each_with_index:::::::::::::::'
[1, 2, 3].each_with_index do |item, index|
  print index, item
  puts "\n"
end

puts 'my_each_with_index:::::::::::::::'
[1, 2, 3].my_each_with_index do |item, index|
  print index, item
  puts "\n"
end

puts 'select::::::::::::::::'
p [1, 2, 3, 4, 5].select(&:even?)

puts 'my_select:::::::::::::'
p [1, 2, 3, 4, 5].my_select(&:even?)
puts 'all?::::::::::::::::::::'
puts %w[ant bear cat].all? { |word| word.length >= 3 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts %w[ant bear cat].all? { |word| word.length >= 4 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts 'all?:::Regex:::::::::::::::::'
puts %w[ant bear cat].all?(/t/)
puts %w[ant beat cat].all?(/t/)
puts %w[ant beat cat].my_all?('*')
puts %w[ant beat cat].my_all?('BOOM/')
puts [1, 2i, 3.14].all?(Numeric)
puts %w[ant bear cat].my_all?(String)
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
puts %w[ant beat cat].my_all?('BOOM/')
puts [1, 2i, 3.14].my_all?(Numeric)
puts %w[ant bear cat].my_all?(String)
puts [nil, true, 99].my_all?
puts [1, true, 99].my_all?
puts [].my_all?

puts 'any?::::::::::::::::::::'
puts %w[ant bear cat].any? { |word| word.length >= 3 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts %w[ant bear cat].any? { |word| word.length >= 4 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts %w[ant bear cat].any?(/d/) #=> false
puts [nil, true, 99].any?(Integer) #=> true
puts [nil, true, 99].any? #=> true
puts [].any? #=> false

puts 'my_any?::::::::::::::::::::'
puts %w[ant bear cat].my_any? { |word| word.length >= 3 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts %w[ant bear cat].my_any? { |word| word.length >= 4 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts %w[ant bear cat].my_any?(/d/) #=> false
puts [nil, true, 99].my_any?(Integer) #=> true
puts [nil, true, 99].my_any? #=> true
puts [].my_any? #=> false

puts 'none?::::::::::::::::::::::::::::::::'
puts %w[ant bear cat].none? { |word| word.length == 5 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts %w[ant bear cat].none? { |word| word.length >= 4 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts %w[ant bear cat].none?(/d/) #=> true
puts [1, 3.14, 42].none?(Float) #=> false
puts [].none? #=> true
puts [nil].none? #=> true
puts [nil, false].none? #=> true
puts [nil, false, true].none? #=> false

puts 'my_none?::::::::::::::::::::::::::::::::'
puts %w[ant bear cat].my_none? { |word| word.length == 5 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts %w[ant bear cat].my_none? { |word| word.length >= 4 } # rubocop:todo Lint/AmbiguousBlockAssociation
puts %w[ant bear cat].my_none?(/d/) #=> true
puts [1, 3.14, 42].my_none?(Float) #=> false
puts [].my_none? #=> true
puts [nil].my_none? #=> true
puts [nil, false].my_none? #=> true
puts [nil, false, true].my_none? #=> false

puts 'count::::::::::::::'
# result_count = [1, 2, 4, 2].count do |num|
#   num.even?
# end

result_count = [1, 2, 4, 2].count(&:even?)
p result_count

puts 'my_count::::::::::::::'
# my_result_count = [1, 2, 4, 2].my_count do |num|
#   num.even?
# end
my_result_count = [1, 2, 4, 2].my_count(&:even?)
p my_result_count

puts 'map:::::::::::::::::::::::::'
p(1..4).map { |i| i * i }

puts 'my_map:::::::::::::::::::::::::'
p(1..4).my_map { |i| i * i }

puts 'my_map_accepts_proc_and_block  when a block is passed:::::::::::::::::::::::::'
p(1..4).my_map_accepts_proc_and_block(nil) { |i| i * i }

puts 'my_map_accepts_proc:::::::::::::::::::::::::'
proc = proc do |i|
  i * i
end
p (1..4).my_map_accepts_proc proc

puts 'my_map_accepts_proc_and_block when a proc is passed:::::::::::::::::::::::::'
proc = proc do |i|
  i * i
end
p (1..4).my_map_accepts_proc_and_block proc

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

def multiply_els(array)
  array.my_inject(1) { |product, n| product * n }
end
puts multiply_els([2, 4, 5])
