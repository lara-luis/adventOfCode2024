class Day9
  def initialize()
    @file_ids = Hash.new
  end

  def read_process_input
    res = []
    id = 0
    file_id = 0

    File.open("Day9\\input9.txt", "r") do |f|
      f.each_line do |line|
        digits = line.chars
        for i in 0..digits.length-1  
          if i % 2 == 0
            res.concat(Array.new(digits[i].to_i, id.to_s))

            if @file_ids[id] == nil
              @file_ids[id] = file_id
              file_id += 1
            end
            id += 1
          else
            res.concat(Array.new(digits[i].to_i, "."))
          end
        end 
      end
    end
    return res
  end

  def move_blocks(disk_map)
    digits = disk_map.reverse
    i = 0
    moved = false
    while i < digits.size do
        if digits[i] != "."
          empty_index = digits.rindex(".")
          if empty_index != nil && empty_index > i
            curr_value = digits[i]
            # count the digits 
            num_equal_digits = 0
            curr_index = i
            while digits[curr_index] == curr_value && i < digits.size
              num_equal_digits += 1
              curr_index += 1 
            end

            # find the empty space
            empty_index = find_empty_slow(digits, num_equal_digits, i)

            # move
            moved_digits = num_equal_digits
            if empty_index > -1
              moved = true
              while num_equal_digits > 0 do
                digits[empty_index] = curr_value
                empty_index -= 1
                num_equal_digits -= 1
              end

              while moved_digits > 0 do
                digits[i] = "."
                moved_digits -= 1
                i += 1
              end

            else 
              i += num_equal_digits-1
            end

          else
            break
          end
        end
      if !moved
        i+=1
      else
        moved = false
      end
    end
    digits = digits.reverse
    return digits
  end

  def calculate_checksum(disk_compacted)
    res = 0
    disk_compacted.each_with_index do |digit, i|
      if digit != '.'
        res += digit.to_i * i
      end
    end
    puts res
  end

  def find_empty_slow(digits, slot_size, until_index)
    digits_clone = digits
    empty_ind = digits.rindex(".")
    
    found = false
    found_index = -1

    curr_space_count = 0
    space_index = empty_ind

    if space_index != nil
      while space_index != nil && space_index > 0 do
        starting_index = space_index

        while digits_clone[space_index] == "." && space_index > 0 do
          space_index = space_index - 1
          curr_space_count += 1
        end

        if space_index <= until_index
          break
        end

        if curr_space_count >= slot_size
          found_index = starting_index
          break
        else 
          digits_clone = digits_clone[0..space_index]
          space_index = digits_clone.rindex(".")
          curr_space_count = 0
        end
      end
    end

    return found_index
  end
end


day9 = Day9.new()
disk_map = day9.read_process_input
compacted_disk = day9.move_blocks(disk_map)
puts day9.calculate_checksum(compacted_disk)