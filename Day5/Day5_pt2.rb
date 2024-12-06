class Day5
  def initialize()
    @orders = Hash.new { |hash, key| hash[key] = [] }
    @invalid_updates = []
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
        end
      end
    end

    for update in @invalid_updates
      reordered_update = reorder_update(update)
      sum += get_middle_value(reordered_update)
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
        @invalid_updates.push(pages)  
        return false
      end
    end

    return true
  end

  def reorder_update(update)
    reordered = update

    for i in 0..reordered.length-1
      sub_list_until_curr = update[0..i]
      element_precedence = @orders[update[i]]
      common_elements = element_precedence & sub_list_until_curr
      if common_elements.length > 0
        index = update.index(common_elements[0])
        first = reordered[i] 
        reordered[i] = reordered[index] 
        reordered[index] = first
        return reorder_update(update)
      end
    end
    return reordered
  end

  def get_middle_value(update)
    return update[update.length/2].to_i
  end

end

day5 = Day5.new()
puts day5.read_process_input