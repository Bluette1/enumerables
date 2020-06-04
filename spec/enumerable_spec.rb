require_relative '../enumerable'

describe 'enumerable' do
  describe '#my_each' do
    let(:item) { [1, 2, 3, 4] }

    it 'returns an enumerator with the expected values' do
      expect(item.my_each.to_a).to match_array(item.each.to_a)
    end

    it 'returns the expected result when passed a block' do
      expected = []
      actual = []
      item.each { |element| expected << element + 10 }
      item.my_each { |element| actual << element + 10 }
      expect(expected).to match_array(actual)
    end
  end

  describe '#my_each_with_index' do
    let(:item) { [1, 2, 3, 4] }
    it 'returns an enumerator with the expected values' do
      expect(item.my_each_with_index.class).to eql(item.each_with_index.class)
      expect(item.my_each_with_index.to_a).to match_array(item.each_with_index.to_a)
    end

    it 'returns the expected result when passed a block' do
      expected = {}
      actual = {}
      item.each_with_index { |item, index| expected[index] = item + 10 }
      item.my_each_with_index { |item, index| actual[index] = item + 10 }
      expect(expected).to match(actual)
    end
  end

  describe '#my_select' do
    let(:item) { [1, 2, 3, 4] }
    it 'returns an enumerator with the expected values' do
      expect(item.my_select.class).to eql(item.select.class)
      expect(item.my_select.to_a).to match_array(item.select.to_a)
    end

    it 'returns the expected result when passed a block' do
      expect(item.select(&:even?)).to match_array(item.my_select(&:even?))
    end
  end

  describe '#my_all' do
    let(:item) { %w[ant bear cat] }

    it 'returns the expected result when passed a block' do
      expect(item.my_all? { |word| word.length >= 3 }).to eq(item.all? { |word| word.length >= 3 })
      expect(item.my_all? { |word| word.length >= 4 }).to eq(item.all? { |word| word.length >= 4 })
      expect(item.my_all? { |word| word.length.even? }).to eq(item.all? { |word| word.length.even? })
    end

    it 'returns the expected result for a regex test' do
      expect(item.my_all?(/t/)).to eq(item.all?(/t/))
      expect(%w[beat beat beat].my_all?).to eq(%w[beat beat beat].all?('beat'))
    end

    let(:item) { %w[ant beat cat] }
    let(:contexts) { [/t/, '*', 'beat', 'BOOM/'] }
    it 'returns the expected result for a regex test' do
      contexts.each do |context|
        expect(item.my_all?(context)).to eq(item.all?(context))
      end
    end
    let(:contexts) { [[[1, 2i, 3.14], %w[ant bear cat], [nil, true, 99]], [Numeric, String, Integer]] }
    let(:length) { contexts[0].length - 1 }
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
    let(:item) { %w[ant bear cat] }

    it 'returns the expected result when passed a block' do
      expect(item.my_any? { |word| word.length >= 3 }).to eq(item.any? { |word| word.length >= 3 })
      expect(item.my_any? { |word| word.length >= 4 }).to eq(item.any? { |word| word.length >= 4 })
      expect(item.my_any? { |word| word.length.even? }).to eq(item.any? { |word| word.length.even? })
    end

    it 'returns the expected result for a regex test' do
      expect(item.my_any?(/t/)).to eq(item.any?(/t/))
      expect(item.my_any?(/d/)).to eq(item.any?(/d/))
      expect(%w[beat beat beat].my_any?('beat')).to eq(%w[beat beat beat].any?('beat'))
    end

    let(:item) { %w[ant beat cat] }
    let(:contexts) { [/t/, '*', 'beat', 'BOOM/'] }
    it 'returns the expected result for a regex test' do
      contexts.each do |context|
        expect(item.my_any?(context)).to eq(item.any?(context))
      end
    end
    let(:contexts) { [[[1, 2i, 3.14], %w[ant bear cat], [nil, true, 99]], [Numeric, String, Integer]] }
    let(:length) { contexts[0].length - 1 }
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
    let(:item) { %w[ant bear cat] }

    it 'returns the expected result when passed a block' do
      expect(item.my_none? { |word| word.length < 3 }).to eq(item.none? { |word| word.length < 3 })
      expect(item.my_none? { |word| word.length >= 4 }).to eq(item.none? { |word| word.length >= 4 })
      expect(item.my_none? { |word| word.length.even? }).to eq(item.none? { |word| word.length.even? })
    end

    it 'returns the expected result for a regex test' do
      expect(item.my_none?(/t/)).to eq(item.none?(/t/))
      expect(%w[beat beat beat].my_none?('beat')).to eq(%w[beat beat beat].none?('beat'))
    end

    let(:item) { %w[ant beat cat] }
    let(:contexts) { [/t/, '*', 'beat', 'BOOM/'] }
    it 'returns the expected result for a regex test' do
      contexts.each do |context|
        expect(item.my_none?(context)).to eq(item.none?(context))
      end
    end
    let(:contexts) do
      [[[1, 2i, 3.14], %w[ant bear cat], [nil, true, 99], [1, 3.14, 42]], [Numeric, String, Integer, Float]]
    end
    let(:length) { contexts[0].length - 1 }
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
    let(:item) { [1, 2, 3, 4] }
    it 'returns the number of elements' do
      expect(item.my_count).to eq(item.count)
    end

    it 'returns the expected result when passed a block' do
      expect(item.my_count(&:even?)).to eq(item.count(&:even?))
    end

    let(:contexts) { [[[1, 2, 4, 2], %w[ant bear cat], [nil, true, 99], [1, 3.14, 42]], [2, 'cat', Integer, Float]] }
    let(:length) { contexts[0].length - 1 }
    it 'returns the expected result for class tests' do
      (0..length).each do |i|
        expect(contexts[0][i].my_count(contexts[1][i])).to eq(contexts[0][i].count(contexts[1][i]))
      end
    end
  end
end