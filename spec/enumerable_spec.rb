require_relative '../enumerable'

describe 'enumerable' do
  let(:item) { [1, 2, 3, 4] }
  let(:item_strings) { %w[ant bear cat] }
  let(:item_strings_other) { %w[ant beat cat] }
  let(:regex_patterns) { [/t/, '*', 'beat', 'BOOM/'] }
  let(:contexts) { [[[1, 2, 4, 2], item_strings, [nil, true, 99], [1, 3.14, 42]], [2, 'cat', Integer, Float]] }
  let(:length) { contexts[0].length - 1 }

  describe '#my_each' do
    it 'returns an enumerator with the expected values when called without arguments' do
      expect(item.my_each.class).to eql(item.each.class)
      expect(item.my_each.to_a).to match_array(item.each.to_a)
    end

    it 'returns the expected result when passed a block' do
      expected = []
      actual = []
      item.each { |element| expected << element + 10 }
      item.my_each { |element| actual << element + 10 }
      expect(expected).to match_array(actual)
      # rubocop:todo Lint/Void
      expect(item.my_each { |element| element }).to eql(item.each { |element| element })
      # rubocop:enable Lint/Void
    end
  end

  describe '#my_each_with_index' do
    it 'returns an enumerator with the expected values when called without arguments' do
      expect(item.my_each_with_index.class).to eql(item.each_with_index.class)
      expect(item.my_each_with_index.to_a).to match_array(item.each_with_index.to_a)
    end

    it 'returns the expected result when passed a block' do
      expected = {}
      actual = {}
      item.each_with_index { |item, index| expected[index] = item + 10 }
      item.my_each_with_index { |item, index| actual[index] = item + 10 }
      expect(expected).to match(actual)
      # rubocop:todo Lint/Void
      expect(item.my_each_with_index { |element| element }).to eql(item.each { |element| element })
      # rubocop:enable Lint/Void
    end
  end

  describe '#my_select' do
    it 'returns an enumerator with the expected values when called without arguments' do
      expect(item.my_select.class).to eql(item.select.class)
      expect(item.my_select.to_a).to match_array(item.select.to_a)
    end

    it 'returns the expected result when passed a block' do
      expect(item.select(&:even?)).to match_array(item.my_select(&:even?))
    end
  end

  describe '#my_all' do
    it 'returns the expected result when passed a block' do
      expect(item_strings.my_all? { |word| word.length >= 3 }).to eq(item_strings.all? { |word| word.length >= 3 })
      expect(item_strings.my_all? { |word| word.length >= 4 }).to eq(item_strings.all? { |word| word.length >= 4 })
      expect(item_strings.my_all? { |word| word.length.even? }).to eq(item_strings.all? { |word| word.length.even? })
    end

    it 'returns the expected result for a regex test' do
      expect(item_strings.my_all?(/t/)).to eq(item_strings.all?(/t/))
      expect(%w[beat beat beat].my_all?).to eq(%w[beat beat beat].all?('beat'))
    end

    it 'returns the expected result for a regex test' do
      regex_patterns.each do |regex_pattern|
        expect(item_strings_other.my_all?(regex_pattern)).to eq(item_strings_other.all?(regex_pattern))
      end
    end

    it 'returns the expected result for class tests' do
      (0..length).each do |i|
        expect(contexts[0][i].my_all?(contexts[1][i])).to eq(contexts[0][i].all?(contexts[1][i]))
      end
    end

    context ' values like nil, [], false' do
      let(:items) { [[nil, true, 99], [1, true, 99], []] }
      it 'returns the expected result for values like nil, [], false ' do
        items.each do |item|
          expect(item.my_all?).to eq(item.all?)
        end
      end
    end
  end

  describe '#my_any' do
    it 'returns the expected result when passed a block' do
      expect(item_strings.my_any? { |word| word.length >= 3 }).to eq(item_strings.any? { |word| word.length >= 3 })
      expect(item_strings.my_any? { |word| word.length >= 4 }).to eq(item_strings.any? { |word| word.length >= 4 })
      expect(item_strings.my_any? { |word| word.length.even? }).to eq(item_strings.any? { |word| word.length.even? })
    end

    it 'returns the expected result for a regex test' do
      expect(item_strings.my_any?(/t/)).to eq(item_strings.any?(/t/))
      expect(item_strings.my_any?(/d/)).to eq(item_strings.any?(/d/))
      expect(%w[beat beat beat].my_any?('beat')).to eq(%w[beat beat beat].any?('beat'))
    end

    it 'returns the expected result for a regex test' do
      regex_patterns.each do |regex_pattern|
        expect(item_strings.my_any?(regex_pattern)).to eq(item_strings.any?(regex_pattern))
      end
    end

    it 'returns the expected result for class tests' do
      (0..length).each do |i|
        expect(contexts[0][i].my_any?(contexts[1][i])).to eq(contexts[0][i].any?(contexts[1][i]))
      end
    end

    context ' values like nil, [], false' do
      let(:items) { [[nil, true, 99], [1, true, 99], []] }
      it 'returns the expected result for values like nil, [], false ' do
        items.each do |item|
          expect(item.my_any?).to eq(item.any?)
        end
      end
    end
  end

  describe '#my_none' do
    it 'returns the expected result when passed a block' do
      expect(item_strings.my_none? { |word| word.length < 3 }).to eq(item_strings.none? { |word| word.length < 3 })
      expect(item_strings.my_none? { |word| word.length >= 4 }).to eq(item_strings.none? { |word| word.length >= 4 })
      expect(item_strings.my_none? { |word| word.length.even? }).to eq(item_strings.none? { |word| word.length.even? })
    end

    it 'returns the expected result for a regex test' do
      expect(item_strings.my_none?(/t/)).to eq(item_strings.none?(/t/))
      expect(%w[beat beat beat].my_none?('beat')).to eq(%w[beat beat beat].none?('beat'))
    end

    it 'returns the expected result for a regex test' do
      regex_patterns.each do |regex_pattern|
        expect(item_strings_other.my_none?(regex_pattern)).to eq(item_strings_other.none?(regex_pattern))
      end
    end

    it 'returns the expected result for class tests' do
      (0..length).each do |i|
        expect(contexts[0][i].my_none?(contexts[1][i])).to eq(contexts[0][i].none?(contexts[1][i]))
      end
    end

    context ' values like nil, [], false' do
      let(:items) { [[nil, true, 99], [1, true, 99], [], [nil], [nil, false], [nil, false, true]] }
      it 'returns the expected result for values like nil, [], false ' do
        items.each do |item|
          expect(item.my_none?).to eq(item.none?)
        end
      end
    end
  end

  describe '#my_count' do
    it 'returns the number of elements' do
      expect(item.my_count).to eq(item.count)
    end

    it 'returns the expected result when passed a block' do
      expect(item.my_count(&:even?)).to eq(item.count(&:even?))
    end

    it 'returns the expected result for class tests' do
      (0..length).each do |i|
        expect(contexts[0][i].my_count(contexts[1][i])).to eq(contexts[0][i].count(contexts[1][i]))
      end
    end
  end

  describe '#my_map' do
    func = proc do |i|
      i * i
    end

    it 'returns an enumerator with the expected values when called without arguments' do
      expect(item.my_map.class).to eql(item.map.class)
      expect(item.my_map.to_a).to match_array(item.map.to_a)
    end

    it 'returns the expected result when passed a block' do
      expect(item.my_map { 'cat' }).to eql(Array.new(4, 'cat'))
      expect(item.my_map(&:to_s)).to eq(%w[1 2 3 4])
      expect(item.my_map(&func)).to eq(item.map(&func))
      expect(item.my_map { |i| i * i * i }).to eq([1, 8, 27, 64])
    end
  end

  describe '#my_map_accepts_proc' do
    func = proc do |i|
      i * i
    end

    it 'returns an enumerator with the expected values when called without a proc or block' do
      expect(item.my_map_accepts_proc(nil).class).to eql(item.map.class)
      expect(item.my_map_accepts_proc(nil).to_a).to match_array(item.map.to_a)
    end

    it 'returns the expected result when passed a proc' do
      expect(item.my_map_accepts_proc(func)).to eq(item.map(&func))
    end
  end

  describe '#my_inject' do
    it 'accepts a symbol that references a block as an argument' do
      expect(item.my_inject(:+)).to eq(10)
    end
    it 'accepts a block' do
      expect(item.my_inject { |sum, n| sum + n }).to eq(10)
    end
    it 'accepts an argument as a an initiator value well as symbol as a block reference' do
      expect((5..10).my_inject(1, :*)).to eq(151_200)
    end
  end

  describe '#multiply_els' do
    it 'returns the expected result' do
      expect(multiply_els(item)).to eq(24)
    end
  end
end
