module Enumerable
    def my_each
        return unless block_given?
        for i in self do
            yield i
        end
    end

    def my_each_with_index
        return unless block_given?
        i = 0
        while i <= self.length - 1
            yield(self[i], i)
            i += 1
        end
    end

    def my_select
        return unless block_given?
        self.my_each { |i| yield i }
    end

    def my_all?(param = nil)
        if block_given?
            my_each { |item| return false if yield(item) == false }
        elsif param.nil?
            my_each { |item| return false if item.nil? || item == false }
        elsif param.instance_of?(Regexp)
            my_each { |item| return false unless param.match(item) }
        elsif param.is_a? Class
            my_each { |item| return false unless [item.class, item.class.superclass].include?(param) }
        end
        true
    end

    def my_any?(param = nil)
        if block_given?
            my_each { |item| return true if yield(item) == true }
        elsif param.nil?
            my_each { |item| return true if item.nil? || item == true }
        elsif param.instance_of?(Regexp)
            my_each { |item| return true if param.match(item) }
        elsif param.is_a? Class
        my_each { |item| return true if [item.class, item.class.superclass].include?(param) }
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

end