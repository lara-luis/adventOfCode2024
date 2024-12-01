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
  end

  def calculateDistances
    res = 0

    for i in 0..(@list1.size()-1) do
      count = @list2.count(@list1[i]) 
      res += @list1[i] * count
    end

    return res
  end
end

day1 = Day1.new()
day1.read_file
puts day1.calculateDistances