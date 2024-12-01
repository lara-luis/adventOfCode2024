class Day1
  def initialize()
     @list1 = []
     @list2 = []
  end

  def read_file
    File.open("Day1\\input1.txt", "r") do |f|
      f.each_line do |line|
        nums = line.split 
        @list1 << nums[0].to_i
        @list2 << nums[1].to_i
      end
    end

    @list1.sort!
    @list2.sort!
  end

  def calculateDistances
    res = 0

    for i in 0..(@list1.size()-1) do
      distance = (@list1[i].to_i - @list2[i].to_i).abs    
      res += distance
    end

    return res
  end
end

day1 = Day1.new()
day1.read_file
puts day1.calculateDistances