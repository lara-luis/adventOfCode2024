class Day11
  def initialize()
    @times = 25
    @stones = []
  end

  def read_file
    i = 0
    File.open("Day11\\input11.txt", "r") do |f|
      f.each_line.with_index do |line, i|
        @stones = line.split(" ").map(&:to_i)
      end
    end
  end
  
  def process_stones
    curr_blink = 0
    
    while curr_blink < @times do
      j = 0
      stones_count = @stones.length 
      while j <= stones_count-1
        if @stones[j] == 0
          @stones[j] = 1
        elsif @stones[j].to_s.chars.length % 2 == 0
          midpoint = @stones[j].to_s.length / 2
          splitted_number_1 = @stones[j].to_s[0...midpoint]
          splitted_number_2 = @stones[j].to_s[midpoint..-1]
          @stones[j] = splitted_number_1.to_i
          @stones.insert(j+1, splitted_number_2.to_i)
          j += 1
          stones_count += 1
        else
          @stones[j] = @stones[j] * 2024
        end 
        j += 1
      end
      curr_blink += 1
    end
  end

  def get_stones_number 
    return @stones.length
  end
end

day11 = Day11.new()
day11.read_file
day11.process_stones
puts day11.get_stones_number