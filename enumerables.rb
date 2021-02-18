module Enumerable
  def my_each
    return to_enum(:my_each) unless block_given?

    for i in self do
      yield i
    end
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    i = 0
    while i <= size - 1
      yield(to_a[i], i)
      i += 1
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    array = []
    to_a.my_each { |item| array << item if yield item }
    array
  end

  # rubocop:disable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity/

  def my_all?(param = nil)
    if block_given?
      my_each { |item| return false if yield(item) == false }
    elsif param.nil?
      my_each { |item| return false if item.nil? || item == false }
    elsif param.instance_of?(Regexp)
      my_each { |item| return false unless param.match(item) }
    elsif param.is_a? Class
      my_each { |item| return false unless [item.class, item.class.superclass].include?(param) }
    else
      my_each { |item| return false if item != param }
    end
    true
  end

  def my_any?(param = nil)
    if block_given?
      my_each { |item| return true if yield(item) == true }
    elsif param.nil?
      my_each { |item| return true if item }
    elsif param.instance_of?(Regexp)
      my_each { |item| return true if param.match(item) }
    elsif param.is_a? Class
      my_each { |item| return true if [item.class, item.class.superclass].include?(param) }
    else
      my_each { |item| return false if item != param }
    end
    false
  end

  def my_none?(param = nil)
    if block_given?
      my_each { |item| return false if yield(item) == true }
    elsif param.nil?
      my_each { |item| return false if item }
    elsif param.instance_of?(Regexp)
      my_each { |item| return true unless param.match(item) }
    elsif param.is_a? Class
      my_each { |item| return false unless [item.class, item.class.superclass].include?(param) }
    end
    true
  end

  def my_count(param = nil)
    count = 0
    if block_given?
      my_each { |item| count += 1 if yield(item) }
    elsif !param.nil?
      my_each { |item| count += 1 if item == param }
    else
      count = length
    end
    count
  end

  def my_map(param = nil)
    return to_enum(:my_map) unless block_given?

    new_array = []
    if param.nil?
      my_each { |item| new_array.push(yield(item)) }
    else
      my_each { |item| new_array.push(param.call(item)) }
    end
    new_array
  end

  def my_inject(*arg)
    return to_enum if !block_given? && arg == nil?

    control = false
    result = Array(self)[0]
    if (arg[0].class.instance_of? Symbol) || arg[0].nil?
      control = true
    elsif arg[0].is_a? Numeric
      result = arg[0]
    end
    Array(self).my_each_with_index do |item, index|
      next if control && index.zero?

      if block_given?
        result = yield(result, item)
      elsif arg[0].is_a? Symbol
        result = result.send(arg[0], item)
      elsif arg[0].is_a? Numeric
        result = result.send(arg[1], item)
      end
    end
    result
  end
end

def multiply_els(array)
  puts array.my_inject(:*)
end

# rubocop:enable Metrics/PerceivedComplexity,Metrics/CyclomaticComplexity
