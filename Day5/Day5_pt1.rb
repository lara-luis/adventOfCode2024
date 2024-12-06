class Day5
  def initialize()
    @orders = Hash.new { |hash, key| hash[key] = [] }
  end

  def read_process_input
    sum = 0

    File.open("Day5\\input5.txt", "r") do |f|
      f.each_line do |line|
        if line.include?("|")
          nums = line.split('|')
          vals = @orders[nums[0].to_i]
          vals.push(nums[1].to_i)
          @orders[nums[0].to_i] = vals
        elsif
          update = line.split(',')
          is_valid = is_update_valid(update) 
          sum += get_middle_value(update) if is_valid
        end
      end
    end
    puts sum
  end

  def is_update_valid(update)
    pages = update.map(&:to_i)

    for i in 0..pages.length-1
      sub_list_until_curr = pages[0..i]
      element_rules = @orders[pages[i]]
      common_elements = element_rules & sub_list_until_curr
      if common_elements.length > 0
        return false
      end
    end

    return true
  end

  def get_middle_value(update)
    return update[update.length/2].to_i
  end

end

day5 = Day5.new()
puts day5.read_process_input