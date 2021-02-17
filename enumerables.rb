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
    
end