class Day3
  def initialize()

  end

  def read_mulls
    sum = 0

    File.open("Day3\\input3.txt", "r") do |f|
      f.each_line do |line|
        pattern = /mul\((-?\d+),\s*(-?\d+)\)/
        mulls = line.scan(pattern)
        for pair in mulls
          if pair.first != nil && pair.last != nil
            sum += process_mult(pair.first.to_i, pair.last.to_i)
          end
        end
      end
    end
    return sum
  end

  def process_mult(a,b)
    return a*b
  end
end

day3 = Day3.new()
puts day3.read_mulls