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
      for i in 0..digits.size-1
        if digits[i] != "."
          empty_index = digits.rindex(".")
          if empty_index != nil && empty_index > i
            digits[empty_index] = digits[i]
            digits[i] = "."
          else
            break
          end
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
end


day9 = Day9.new()
disk_map = day9.read_process_input
compacted_disk = day9.move_blocks(disk_map)
puts day9.calculate_checksum(compacted_disk)