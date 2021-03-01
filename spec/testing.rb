require_relative '../enumerables'

describe Enumerable do
  let(:num_arr) { [1, 2, 3, 4, 5] }

  describe 'my_each' do
    it 'calls the block on each item of array' do
      expect(num_arr.my_each { |item| }).to eql([1, 2, 3, 4, 5])
    end
  end

  describe 'my_each_with_index' do
    it 'returns array element with the index' do
      expect(num_arr.my_each_with_index { |item| }).to eql(num_arr)
    end
  end

  describe 'my_select' do
    it 'returns only the selected items' do
      expect(num_arr.my_select { |item| item != 5 }).to eql([1, 2, 3, 4])
    end
  end

  describe 'my_all?' do
    it 'returns true if all the items are true' do
      expect(num_arr.my_all? { |item| item.is_a? Integer }).to be true
    end

    it 'returns false if all the items are not true' do
      expect(num_arr.my_all? { |item| item.is_a? String }).to be false
    end
  end

  describe 'my_any?' do
    it 'returns true if any of the items are true' do
      expect(num_arr.my_any? { |item| item.is_a? Integer }).to be true
    end

    it 'returns false if none of the items are true' do
      expect(num_arr.my_any? { |item| item.is_a? String }).to be false
    end
  end

  describe 'my_none?' do
    it 'returns false if none of the items are true' do
      expect(num_arr.my_none? { |item| item.is_a? Integer }).to be false
    end
    it 'returns true if none of the items are true' do
      expect(num_arr.my_none? { |item| item.is_a? String }).to be true
    end
  end
  describe 'my_count' do
    it 'returns the number of items' do
      expect(num_arr.my_count).to eql(5)
    end
  end
  describe 'my_map' do
    it 'returns the modified array' do
      expect(num_arr.my_map { 1 }).to eql([1, 1, 1, 1, 1])
    end
  end
  describe 'my_inject' do
    it 'returns the total sum of each array item' do
      expect(num_arr.my_inject { |sum, item| sum + item }).to eql(15)
    end
  end
  describe '#multiply_els' do
    it 'returns the mulitple of each item in array' do
      expect(multiply_els([1, 2, 3, 4, 5])).to eql(120)
    end
  end
  
end