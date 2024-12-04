class Day3
  def initialize()
  end

  def read_mulls
    sum = 0
    has_do = true

    File.open("Day3\\input3.txt", "r") do |f|
      f.each_line do |line|
        pattern = /(mul\((-?\d+),\s*(-?\d+)\))|(do\(\))|(don't\(\))/
        mulls = line.scan(pattern)
    
        for pair in mulls
          has_do = true if pair[3] == "do()"
          has_do = false if pair[4] == "don't()"  
          
          if pair[1] != nil && pair[2] != nil
            if has_do
              sum += process_mult(pair[1].to_i, pair[2].to_i)
            end
          end
        end
      end
    end
    return sum
  end

  def process_mult(a, b)
    return a * b
  end
end

day3 = Day3.new()
puts day3.read_mulls