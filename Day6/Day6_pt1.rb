require "set"

class Day6
  def initialize()
    @map = []
    @current_position = [0, 0]
    @visited_positions = Set.new
    @direction = ""
  end

  def read_process_input
    File.open("Day6\\input6.txt", "r") do |f|
      f.each_line.with_index do |line, i|
        @map[i] = line.chars
        if line.include?('^')
          @current_position = [i, line.index('^')]
          @direction = "up"
        elsif line.include?('v')
          @current_position = [i, line.index('v')]
          @direction = "down"
        elsif line.include?('<')
          @current_position = [i, line.index('<')]
          @direction = "left"
        elsif line.include?('>')
          @current_position = [i, line.index('>')]
          @direction = "right"
        end
      end
    end
  end

  def follow_path
    current_pos = @current_position
    @visited_positions.add(current_pos)
    stop = false

    while !stop
      case @direction
      when "up"
        if @map[current_pos[0] - 1][current_pos[1]] == "#"
          current_pos = [current_pos[0], current_pos[1] + 1]
          @direction = "right"
        else
          current_pos = [current_pos[0] - 1, current_pos[1]]
        end
      when "down"
        if @map[current_pos[0] + 1][current_pos[1]] == "#"
          current_pos = [current_pos[0], current_pos[1] - 1]
          @direction = "left"
        else
          current_pos = [current_pos[0] + 1, current_pos[1]]
        end
      when "left"
        if @map[current_pos[0]][current_pos[1] - 1] == "#"
          current_pos = [current_pos[0] - 1 , current_pos[1]]
          @direction = "up"
        else
          current_pos = [current_pos[0], current_pos[1] - 1]
        end
      when "right"        
        if @map[current_pos[0]][current_pos[1] + 1] == "#"
          current_pos = [current_pos[0] + 1, current_pos[1]]
          @direction = "down"
        else
          current_pos = [current_pos[0], current_pos[1] + 1]
        end
      end

      if (current_pos[0] >= @map.size-1 && @direction == "down") || 
          (current_pos[0] <= 0 && @direction == "up") ||
          (current_pos[1] <= 0 && @direction == "left") ||
          (current_pos[1] >= @map[0].size-1 && @direction == "right")
        stop = true
      else
        @visited_positions.add(current_pos)
      end
  
    end

    puts @visited_positions
    puts @visited_positions.size
  end
end

day6 = Day6.new()
day6.read_process_input
day6.follow_path