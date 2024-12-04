class Day2
  def initialize()

  end

  def read_and_safe_reports
    num_safe_reports = 0

    File.open("Day2\\input2.txt", "r") do |f|
      f.each_line do |line|
        num_safe_reports += 1 if is_safe_report(line)
      end
    end
    
    return num_safe_reports
  end

  def is_safe_report(line)
    nums = line.split 
    previous = -1
    direction_asc = true
    find_order = false

    for i in 0..(nums.length()-1) do
      if i == 0
        previous = nums[i].to_i
        next
      end

      if !find_order
        if previous > nums[i].to_i
          direction_asc = false
          find_order = true
        elsif previous < nums[i].to_i
          direction_asc = true
          find_order = true
        else 
          return false
          next
        end
      end

      if find_order && direction_asc
        if (nums[i].to_i-previous).between?(1,3)
          previous = nums[i].to_i
          next
        else
          return false
        end
      elsif find_order && !direction_asc
        if (previous-nums[i].to_i).between?(1,3)
          previous = nums[i].to_i
          next
        else
          return false
        end
      end 

      previous = nums[i].to_i
    end

    return true
  end
end

day2 = Day2.new()
puts day2.read_and_safe_reports