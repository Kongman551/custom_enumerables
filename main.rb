module Enumerable 
    def my_each(&my_block)
        return unless block_given?

        for item in self
            yield(item)
        end
    end

    def my_each_with_index()
        return unless block_given?

        for item in 0..self.size - 1
            yield(self[item], item)
        end
    end

    def my_map
        return unless block_given?

        new_array = []
        for item in self
           new_array << yield(item) 
        end
        new_array
    end


    def my_select
        return unless block_given?

        new_array = []
        if block_given?
            my_each {|item| new_array << item if yield item}
        end 
        new_array
    end 

    def my_all?
        return unless block_given?
        
        new_array = []

        if block_given?
            my_each {|item| new_array << item if yield item}
        end 
        if new_array == self
            return true
        else 
            return false
        end
    end

    def my_any?
        return unless block_given?
        
        new_array = []
        if block_given?
            my_each {|item| new_array << item if yield item}
        end 
        if new_array.size > 0
            return true
        else
            return false
        end
    end

    def my_none?
        return unless block_given?
        
        new_array = []
        if block_given?
            my_each {|item| new_array << item if yield item}
        end 
        if new_array.size == 0
            return true
        else
            return false
        end
    end

    def my_count 
        return unless block_given?
        
        new_array = []
        if block_given?
            my_each {|item| new_array << item if yield item}
        end 
        return new_array.size

    end

    def my_inject initial_value=nil
        accumulator = initial_value ? initial_value : self.first
        if initial_value
          my_each { |item| accumulator = yield(accumulator, item) }
        else
          shift = is_a?(Hash) ? slice(keys[1], keys[-1]) : self[1..-1]
          shift.my_each { |item| accumulator = yield(accumulator, item) }
        end
        accumulator
    end
end

def multiply_els(arr)
    puts "#inject: #{arr.inject {|s, i| s * i}}\n"
    puts "#my_inject #{arr.my_inject{|s, i| s * i}}"
end

#l = lambda {|item| puts item + 10}
my_proc = Proc.new {|item| puts item + 10}
proc2 = Proc.new {|item, idx| puts "#{item} - #{idx}" }
proc4 = Proc.new {|item| item.even?}
numbers = [1,2,3,4,5]

puts "my_each vs. each"
numbers.my_each(&my_proc)
numbers.each(&my_proc)

puts "\nmy_each_with_index vs each_with_index"
numbers.my_each_with_index {|item, idx| puts "#{item} - #{idx}" }
numbers.each_with_index {|item, idx| puts "#{item} - #{idx}" }

puts "\nmy_map vs. map"
numbers.my_map {|item| puts item + 15}
numbers.map {|item| puts item + 15}

puts "\nmyselect vs. select"
puts numbers.select(&proc4)
puts numbers.my_select {|item| item.even?}

puts "\nmy_all? vs all?"
puts numbers.all? {|item| item > 0}
puts numbers.my_all? {|item| item > 0}

puts "\nmy_any? vs any?"
puts numbers.any? {|item| item > 10}
puts numbers.my_any? {|item| item > 10}

puts "\nmy_none? vs none?"
puts numbers.none? {|item| item == 3}
puts numbers.my_none? {|item| item == 3}

puts "\nmy_count vs count"
puts numbers.count {|item| item < 4}
puts numbers.my_count {|item| item < 4}

puts "\nmy_inject vs inject"
puts numbers.inject {|s, i| s + i} 
puts numbers.my_inject {|s, i| s + i}

puts "\nmultiply_els"
multiply_els(numbers)

puts "\nmy_map accepts proc"
puts numbers.my_map(&my_proc)

