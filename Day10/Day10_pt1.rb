class Day10
  def initialize()
    @matrix = []
    @initial_pos = []
    @hash_initials_pos = Hash.new
  end

  def read_file
    i = 0
    File.open("Day10\\input10.txt", "r") do |f|
      f.each_line.with_index do |line, i|
        chars = line.strip.chars.map(&:to_i)
        @matrix[i] = chars
        for j in 0..chars.length-1
          if @matrix[i][j] == 0
            @initial_pos.push([i, j])
          end
        end
        i += 1
      end
    end
  end

  def calculate_trails
    sum_scores = 0

    @initial_pos.each do |coord|
      score = follow_trail(coord, coord)
      sum_scores += score
    end

    sum_scores = 0
    @hash_initials_pos.each do | initial, targets |
      sum_scores += targets.uniq.length
    end
    return sum_scores
  end

  def follow_trail(current_coords, initial_coord)
    next_value = @matrix[current_coords[0]][current_coords[1]] + 1
    target_value = 9
    coord_score = 0

    if @matrix[current_coords[0]][current_coords[1]] == target_value
      if @hash_initials_pos.key?(initial_coord) 
        @hash_initials_pos[initial_coord].push(current_coords)
      elsif
        @hash_initials_pos[initial_coord] = [current_coords]
      end
      return 1
    else
      up = [current_coords[0] - 1, current_coords[1]]
      up_is_valid = up[0] >= 0
      down = [current_coords[0] + 1, current_coords[1]]
      down_is_valid = down[0] < @matrix.length
      left = [current_coords[0], current_coords[1] - 1]
      left_is_valid = left[1] >= 0
      right = [current_coords[0], current_coords[1] + 1]
      right_is_valid = right[1] < @matrix[0].length

      if up_is_valid && @matrix[up[0]][up[1]] == next_value
        coord_score += follow_trail(up, initial_coord)
      end
      if down_is_valid && @matrix[down[0]][down[1]] == next_value
        coord_score += follow_trail(down, initial_coord)
      end
      if left_is_valid && @matrix[left[0]][left[1]] == next_value
        coord_score += follow_trail(left, initial_coord)
      end
      if right_is_valid && @matrix[right[0]][right[1]] == next_value
        coord_score += follow_trail(right, initial_coord)
      end
    end

    return coord_score
  end 
end

day10 = Day10.new()
day10.read_file
puts day10.calculate_trails