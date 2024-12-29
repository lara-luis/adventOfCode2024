class Day15
  def initialize()
    @matrix = []
    @directions = []
    @robot_initial_position = []
  end

  def read_process_input
    started = false  
    ended = false

    File.open("Day15\\input15.txt", "r") do |f|
      f.each_line.with_index do |line, index|
        if !started && line.include?("########")
          started = true
          @matrix[index] = line.chars
        elsif started && line.include?("########")
          ended = true
          @matrix[index] = line.chars
        elsif !ended && line.strip.length > 0
          @matrix[index] = line.chars
        end

        if line.include?("@")
          @robot_initial_position = [index, line.index("@")]
        end

        if ended && line.strip.length > 0
          @directions.concat(line.chars) 
        end
      end 
    end
  end

  def make_robot_moves
    robot_pos = @robot_initial_position
    
    while @directions.length > 0 do
      direction = @directions.shift
      case direction
      when '<'
        left_char_pos = [robot_pos[0], robot_pos[1] - 1]
        left_char = @matrix[left_char_pos[0]][left_char_pos[1]]
        if left_char == "O"
          left_of_left_char = @matrix[robot_pos[0]][robot_pos[1] - 2]
          if left_of_left_char == "#"
            # do nothing
          elsif left_of_left_char == "."
            @matrix[robot_pos[0]][robot_pos[1] - 2] = "O"
            @matrix[robot_pos[0]][robot_pos[1] - 1] = "@"
            @matrix[robot_pos[0]][robot_pos[1]] = "."
            robot_pos = [robot_pos[0], robot_pos[1] - 1]
          elsif left_of_left_char == "O"
            i = 2
            moves = true
            tmp_left_of_left_char = left_of_left_char
            change_pos = [robot_pos[0], robot_pos[1] - 2]
            while tmp_left_of_left_char == "O" && moves do 
              tmp_left_of_left_char = @matrix[robot_pos[0]][robot_pos[1] - i]
              if tmp_left_of_left_char == "#"
                moves = false
              elsif tmp_left_of_left_char == "."
                moves = true
                change_pos = [robot_pos[0], robot_pos[1] - i]
                break
              end
              i += 1
            end 

            if moves
              @matrix[robot_pos[0]][robot_pos[1]] = "."
              robot_pos = left_char_pos
              @matrix[left_char_pos[0]][left_char_pos[1]] = "@"
              @matrix[change_pos[0]][change_pos[1]] = "O"
            end 
          end 
        elsif left_char == "#"
          # do nothing
        else
          # just move the robot to the left
          @matrix[left_char_pos[0]][left_char_pos[1]] = "@"
          @matrix[robot_pos[0]][robot_pos[1]] = "."
          robot_pos = left_char_pos
        end
      when '>'
        right_char_pos = [robot_pos[0], robot_pos[1] + 1]
        right_char = @matrix[right_char_pos[0]][right_char_pos[1]]
        puts "RIGHT CHAR: #{right_char}"
        puts "RIGHT CHAR POS: #{right_char_pos}"
        if right_char == "O"
          right_of_right_char = @matrix[robot_pos[0]][robot_pos[1] + 2]
          if right_of_right_char == "#"
            # do nothing
          elsif right_of_right_char == "."
            puts "SHOULD BE HERE"
            @matrix[robot_pos[0]][robot_pos[1] + 2] = "O"
            @matrix[robot_pos[0]][robot_pos[1] + 1] = "@"
            @matrix[robot_pos[0]][robot_pos[1]] = "."
            robot_pos = [robot_pos[0], robot_pos[1] + 1]
          elsif right_of_right_char == "O"
            i = 2
            moves = true
            tmp_right_of_right_char = right_of_right_char
            change_pos = [robot_pos[0], robot_pos[1] + 2]
            while tmp_right_of_right_char == "O" && moves do 
              tmp_right_of_right_char = @matrix[robot_pos[0]][robot_pos[1] + i]
              if tmp_right_of_right_char == "#"
                moves = false
              elsif tmp_right_of_right_char == "."
                moves = true
                change_pos = [robot_pos[0], robot_pos[1] + i]
                break
              end
              i += 1
            end 

            if moves
              @matrix[robot_pos[0]][robot_pos[1]] = "."
              robot_pos = right_char_pos
              @matrix[right_char_pos[0]][right_char_pos[1]] = "@"
              @matrix[change_pos[0]][change_pos[1]] = "O"
            end 
          end 
        elsif right_char == "#"
          # do nothing
        else
          # just move the robot to the left
          @matrix[right_char_pos[0]][right_char_pos[1]] = "@"
          @matrix[robot_pos[0]][robot_pos[1]] = "."
          robot_pos = right_char_pos
        end
      when '^'
        up_char_pos = [robot_pos[0]-1, robot_pos[1]]
        up_char = @matrix[up_char_pos[0]][up_char_pos[1]]
        if up_char == "O"
          up_of_up_char = @matrix[robot_pos[0] - 2][robot_pos[1]]
          if up_of_up_char == "#"
            # do nothing
          elsif up_of_up_char == "."
            @matrix[robot_pos[0] - 2][robot_pos[1]] = "O"
            @matrix[robot_pos[0] - 1][robot_pos[1]] = "@"
            @matrix[robot_pos[0]][robot_pos[1]] = "."
            robot_pos = [robot_pos[0] - 1, robot_pos[1]]
          elsif up_of_up_char == "O"
            i = 2
            moves = true
            tmp_up_of_up_char = up_of_up_char
            change_pos = [robot_pos[0] - 2, robot_pos[1]]
            while tmp_up_of_up_char == "O" && moves do 
              tmp_up_of_up_char = @matrix[robot_pos[0] - i][robot_pos[1]]
              if tmp_up_of_up_char == "#"
                moves = false
              elsif tmp_up_of_up_char == "."
                moves = true
                change_pos = [robot_pos[0] - i, robot_pos[1]]
                break
              end
              i += 1
            end 

            if moves
              @matrix[robot_pos[0]][robot_pos[1]] = "."
              robot_pos = up_char_pos
              @matrix[up_char_pos[0]][up_char_pos[1]] = "@"
              @matrix[change_pos[0]][change_pos[1]] = "O"
            end 
          end 
        elsif up_char == "#"
          # do nothing
        else
          # just move the robot to the left
          @matrix[up_char_pos[0]][up_char_pos[1]] = "@"
          @matrix[robot_pos[0]][robot_pos[1]] = "."
          robot_pos = up_char_pos
        end
      when 'v'
        down_char_pos = [robot_pos[0] + 1, robot_pos[1]]
        down_char = @matrix[down_char_pos[0]][down_char_pos[1]]
        if down_char == "O"
          down_of_down_char = @matrix[robot_pos[0] + 2][robot_pos[1]]
          if down_of_down_char == "#"
            # do nothing
          elsif down_of_down_char == "."
            @matrix[robot_pos[0] + 2][robot_pos[1]] = "O"
            @matrix[robot_pos[0] + 1][robot_pos[1]] = "@"
            @matrix[robot_pos[0]][robot_pos[1]] = "."
            robot_pos = [robot_pos[0] + 1, robot_pos[1]]
          elsif down_of_down_char == "O"
            i = 2
            moves = true
            tmp_down_of_down_char = down_of_down_char
            change_pos = [robot_pos[0] + 2, robot_pos[1]]
            while tmp_down_of_down_char == "O" && moves do 
              tmp_down_of_down_char = @matrix[robot_pos[0] + i][robot_pos[1]]
              if tmp_down_of_down_char == "#"
                moves = false
              elsif tmp_down_of_down_char == "."
                moves = true
                change_pos = [robot_pos[0] + i, robot_pos[1]]
                break
              end
              i += 1
            end 

            if moves
              @matrix[robot_pos[0]][robot_pos[1]] = "."
              robot_pos = down_char_pos
              @matrix[down_char_pos[0]][down_char_pos[1]] = "@"
              @matrix[change_pos[0]][change_pos[1]] = "O"
            end 
          end 
        elsif down_char == "#"
          # do nothing
        else
          # just move the robot to the left
          @matrix[down_char_pos[0]][down_char_pos[1]] = "@"
          @matrix[robot_pos[0]][robot_pos[1]] = "."
          robot_pos = down_char_pos
        end
      end

      puts @matrix.join("")
      puts @directions.join("")
    end
  end 

  def calculate_boxes_sum
    sum = 0
    @matrix.each_with_index do |row, i|
      row.each_with_index do |v, j|
        if v == "O"
          sum += i*100 + j
        end
      end
    end
    return sum
  end
end

day15 = Day15.new()
day15.read_process_input
puts day15.make_robot_moves
puts day15.calculate_boxes_sum