class Day13
  def initialize()
    
  end

  def read_file
    i = 0
    button_A_X	= 0
    button_A_Y	= 0
    button_B_X	= 0
    button_B_Y	= 0
    prize_X	= 0
    prize_Y	= 0
    tokens_sum = 0

    File.open("Day13\\input13.txt", "r") do |f|
      f.each_line.with_index do |line, i|
        if line.include?("Button A:")
          line.gsub!("Button A: ", "")
          puts line
          splitted_coords = line.strip!.split(",")
          button_A_X = splitted_coords[0].strip.gsub!("X+", "").to_i
          button_A_Y = splitted_coords[1].strip.gsub!("Y+", "").to_i
        end
        if line.include?("Button B:")
          line.gsub!("Button B: ", "")
          puts line
          splitted_coords = line.strip!.split(",")
          button_B_X = splitted_coords[0].strip.gsub!("X+", "").to_i
          button_B_Y = splitted_coords[1].strip.gsub!("Y+", "").to_i
        end
        if line.include?("Prize")
          line.gsub!("Prize: ", "")
          puts "line #{line.strip!}"
          splitted_coords = line.split(", ")
          prize_X = splitted_coords[0].strip.gsub!("X=", "").to_i
          prize_Y = splitted_coords[1].strip.gsub!("Y=", "").to_i

          tokens_min = calculate_min_tokens(button_A_X, button_A_Y, button_B_X, button_B_Y, prize_X, prize_Y)
          tokens_sum += tokens_min
        end
      end
    end
    return tokens_sum
  end

  def calculate_min_tokens(button_A_X, button_A_Y, button_B_X, button_B_Y, prize_X, prize_Y)
    max_int = (2**(0.size * 8 -2) -1)
    min_tokens = max_int

    for i in 0..100
      for j in 0..100
        if i * button_A_X + j * button_B_X == prize_X && i * button_A_Y + j * button_B_Y == prize_Y
          tokens = i*3 + j*1
          if tokens < min_tokens
            min_tokens = tokens
          end
        end
      end
    end

    if min_tokens == max_int
      return 0
    end
    
    return min_tokens
  end
end

day13 = Day13.new()
puts day13.read_file