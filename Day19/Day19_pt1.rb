class Day19
  def initialize()
    
  end

  def read_process_input
    res = 0
    towers = []

    File.open("Day19\\input19.txt", "r") do |f|
      f.each_line.with_index do |line, i|
        if i == 0
          towers = line.gsub("\n", "").split(", ")
          towers = towers.sort_by { |element| element.length }.reverse
        end

        if i > 0 && !line.strip.empty?
          pattern = line
          res += 1 if shuffle_and_try(towers, pattern)
        end
      end
    end
    return res
  end

  def shuffle_and_try(towels, pattern)
    works = false

    for i in 0..700
      shuffled_towels = towels.shuffle
      works = true if is_pattern_possible?(shuffled_towels, pattern)
      if works
        break
      end
    end
    return works
  end 

  def is_pattern_possible?(towels, pattern)
    original_pattern = pattern
    for t in towels
      changed_pattern = pattern.gsub(t, "|")
      if changed_pattern != pattern
        pattern = changed_pattern
      end
    end

    if pattern.strip.gsub("|", "") == ""
      return true
    else
      return false
    end
  end 

end

day19 = Day19.new()
puts day19.read_process_input