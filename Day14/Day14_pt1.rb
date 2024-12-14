class Day14
  def initialize()
    @MAP_HEIGHT = 103
    @MAP_WIDTH = 101
    @matrix = Array.new(@MAP_HEIGHT) { Array.new(@MAP_WIDTH, ".") }
    @ITERATIONS = 100
    @middle_y = (@MAP_HEIGHT / 2).ceil
    @middle_x = (@MAP_WIDTH / 2).ceil
    @first_quadrant_count = 0
    @second_quadrant_count = 0
    @third_quadrant_count = 0
    @fourth_quadrant_count = 0
  end

  def read_process_input
    
    File.open("Day14\\input14.txt", "r") do |f|
      f.each_line do |line|
        line_data = line.split("v=")
        pos = line_data[0].gsub("p=", "").strip
        pos_x = pos.split(",")[0].to_i
        pos_y = pos.split(",")[1].to_i

        vel = line_data[1].gsub("v=", "").strip
        vel_x = vel.split(",")[0].to_i
        vel_y = vel.split(",")[1].to_i

        calculate_final_positions(pos_x, pos_y, vel_x, vel_y)
      end
    end
  end

  def calculate_final_positions(pos_x, pos_y, vel_x, vel_y)
    curr_x = pos_x
    curr_y = pos_y

    for i in 1..@ITERATIONS
      curr_x = curr_x + vel_x
      curr_y = curr_y + vel_y

      if curr_x < 0
        curr_x = @MAP_WIDTH + curr_x
      end 
      if curr_y < 0
        curr_y = @MAP_HEIGHT + curr_y
      end
      if curr_x > @MAP_WIDTH-1
        curr_x = curr_x - @MAP_WIDTH
      end
      if curr_y > @MAP_HEIGHT-1
        curr_y = curr_y - @MAP_HEIGHT
      end

      if i == @ITERATIONS
        if curr_x == @middle_x || curr_y == @middle_y
          #skip
        elsif curr_x < @middle_x && curr_y < @middle_y
          @first_quadrant_count += 1
        elsif curr_x > @middle_x && curr_y < @middle_y
          @second_quadrant_count += 1
        elsif curr_x < @middle_x && curr_y > @middle_y
          @third_quadrant_count += 1
        elsif curr_x > @middle_x && curr_y > @middle_y
          @fourth_quadrant_count += 1
        end
      end 
    end
  end 

  def calculate_safety_factor()
    return @first_quadrant_count * @second_quadrant_count * @third_quadrant_count * @fourth_quadrant_count
  end
end


day14 = Day14.new()
day14.read_process_input
puts day14.calculate_safety_factor