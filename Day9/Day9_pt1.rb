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
    #puts disk_map
    digits = disk_map.reverse
    puts digits
      for i in 0..digits.size-1
        #puts "iteration #{i}"
        if digits[i] != "."
          puts "digit #{digits[i]} at index #{i}"
          empty_index = digits.rindex(".")
          #puts "empty index #{empty_index} #{digits[empty_index]}"
          if empty_index != nil && empty_index > i
            #puts "moving #{digits[i]} from index #{i} to index #{empty_index}"
            digits[empty_index] = digits[i]
            digits[i] = "."

           # puts digits.reverse.join("")
          else
            break
          end
        end
      end
    digits = digits.reverse
    #puts digits
    return digits
  end

  def calculate_checksum(disk_compacted)
    res = 0
    disk_compacted.each_with_index do |digit, i|
      #puts disk_compacted
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