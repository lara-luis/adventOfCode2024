require "set"
require 'timeout'

class Day6
  def initialize()
    @map = []
    @current_position = [0, 0]
    @visited_positions = Set.new
    @direction = ""
    @potential_new_blocker = []
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

  def test_blockers
    num_of_hypothesis = 0

    initial_direction = @direction
    initial_position  = @current_position
    loop = follow_path(initial_direction, initial_position)

    @potential_new_blocker = @visited_positions 
    @visited_positions = Set.new
    @direction = initial_direction

    @potential_new_blocker.each do |blocker|

      @map[blocker[0]][blocker[1]] = "#"
      @direction = initial_direction
      @visited_positions = Set.new

      if true
        is_loop = false
        begin
          status = Timeout.timeout(1) {
            is_loop = follow_path(initial_direction, initial_position)
          }
        rescue Exception
          is_loop = true
        end

        if is_loop
          num_of_hypothesis += 1
        end
        @map[blocker[0]][blocker[1]] = "."
        @direction = initial_direction
        @visited_positions = Set.new
      end
    end

    puts num_of_hypothesis
  end

  def follow_path(initial_direction, initial_position)
    current_pos = initial_position
    @visited_positions.add(current_pos)
    stop = false
    has_loop = false

    pos_directions = Hash.new

    while !stop

      case @direction
      when "up"
        if @map[current_pos[0] - 1][current_pos[1]] == "#"
          @direction = "right"
        else
          current_pos = [current_pos[0] - 1, current_pos[1]]
        end
      when "down"
        if @map[current_pos[0] + 1][current_pos[1]] == "#"
          @direction = "left"
        else
          current_pos = [current_pos[0] + 1, current_pos[1]]
        end
      when "left"
        if @map[current_pos[0]][current_pos[1] - 1] == "#"
          @direction = "up"
        else
          current_pos = [current_pos[0], current_pos[1] - 1]
        end
      when "right"        
        if @map[current_pos[0]][current_pos[1] + 1] == "#"
          @direction = "down"
        else
          current_pos = [current_pos[0], current_pos[1] + 1]
        end
      end

      if @visited_positions.include?(current_pos) && pos_directions[current_pos] == @direction
        has_loop = true
      end

      if (current_pos[0] >= @map.size-1 && @direction == "down") || 
          (current_pos[0] <= 0 && @direction == "up") ||
          (current_pos[1] <= 0 && @direction == "left") ||
          (current_pos[1] >= @map[0].size-1 && @direction == "right")
        stop = true
      else
        @visited_positions.add(current_pos)
        pos_directions[current_pos] = @direction
      end

      if has_loop
        break
      end
    end
  
    return has_loop
  end 
end 

day6 = Day6.new()
day6.read_process_input
day6.test_blockers