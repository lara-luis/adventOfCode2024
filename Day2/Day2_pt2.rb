class Day2
  def initialize()

  end

  def read_and_safe_reports
    num_safe_reports = 0

    File.open("Day2\\input2.txt", "r") do |f|
      f.each_line do |line|
        nums = line.split
        is_safe = is_safe_report(nums, false)
        num_safe_reports += 1 if is_safe
      end
    end
    
    return num_safe_reports
  end

  def is_safe_report(nums, already_removed)
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
          if already_removed
            return false
          else 
            return validate_excluding_levels(nums, i)
          end
        end
      end

      if find_order && direction_asc
        if (nums[i].to_i-previous).between?(1,3)
          last_safe_previous = previous
          previous = nums[i].to_i
          next
        else
          if already_removed
            return false
          else 
            return validate_excluding_levels(nums, i)
          end
        end
      elsif find_order && !direction_asc
        if (previous-nums[i].to_i).between?(1,3)
          last_safe_previous = previous
          previous = nums[i].to_i
          next
        else
          if already_removed
            return false
          else 
            return validate_excluding_levels(nums, i)
          end
        end
      end 
    end

    return true
  end

  def validate_excluding_levels(nums, i)
    clone1 = nums.clone
    clone2 = nums.clone
    nums.delete_at(i)
    clone1.delete_at(i-1)
    clone2.delete_at(i-2)
    return is_safe_report(nums, true) || 
      is_safe_report(clone1, true) || 
      (is_safe_report(clone2, true) if i-2 > -1)

  end
end

day2 = Day2.new()
puts day2.read_and_safe_reports