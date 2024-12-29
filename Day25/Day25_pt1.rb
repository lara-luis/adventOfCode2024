class Day25
  def initialize()
    @keys = []
    @locks = []
    @size = 7
  end

  def read_file
    is_key = false
    is_on_going = false
    curr_line = 0
    curr = [0,0,0,0,0]
    read_lines = 1
    File.open("Day25\\input25.txt", "r") do |f|
      f.each_line.with_index do |line, i|

        if !is_on_going && line.strip == "#####"
          is_on_going = true
          is_key = false # is lock
        elsif is_on_going && read_lines == @size
          is_on_going = false

          if is_key
            @keys.push(curr)
          else
            @locks.push(curr)
          end

          curr = [0,0,0,0,0]
          read_lines = 1
        elsif !is_on_going && line.strip == "....."
          is_on_going = true
          is_key = true # is key
        end 
        
        if is_on_going
          chars = line.strip.chars.map { |c| if c == "#" then 1 else 0 end}
          curr = [curr[0] + chars[0], curr[1] + chars[1], curr[2] + chars[2], curr[3] + chars[3], curr[4] + chars[4]]
          read_lines += 1
        end
      end
    end
  end

  def get_matching_pairs
    matches = 0
    for i in 0..@keys.length-1
      key = @keys[i]
      for j in 0..@locks.length-1
        lock = @locks[j]
        matched_validations = 0
        for k in 0..4
          matched_validations += 1 if key[k] + lock[k] < @size
        end
        matches += 1 if matched_validations == 5
      end
    end
    return matches
  end 
end

day25 = Day25.new()
day25.read_file
puts day25.get_matching_pairs