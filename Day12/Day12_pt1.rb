class Day12
  def initialize()
    @matrix = []
    @width = 0
    @height = 0
    @visited = Hash.new
    @areas_register = Hash.new
    @groups_matrix = []
    @sums = []
  end

  def read_file
    i = 0
    File.open("Day12\\input12.txt", "r") do |f|
      f.each_line.with_index do |line, i|
        chars = line.strip.chars
        @matrix[i] = chars
        @width = chars.length
        i += 1
        @height += 1
      end
    end
  end

  def find_groups
    for i in 0..@height-1
      for j in 0..@width-1 
        if @visited.key?([i,j])
          next
        else 
          collect_group([i,j])
        end
      end
    end 
    return @areas_register
  end

  def collect_group(first_coords)
    queue = [first_coords]
    common_char = @matrix[first_coords[0]][first_coords[1]]
    group_area = 0
    adjacent_sides_count = 0
    group_peremeter = 0
    group_coords = []

    while !queue.empty?
      coords = queue.shift
      i = coords[0]
      j = coords[1]

      if @visited.key?([i,j])
        next
      else
        if @matrix[i][j] == common_char
          group_coords.push([i,j])
          adjacent_sides_count += 1
          group_area += 1
          @visited[[i,j]] = true
          if i-1 >= 0
            queue.push([i-1,j])
          end
          if i+1 < @height
            queue.push([i+1,j])
          end
          if j-1 >= 0
            queue.push([i,j-1])
          end
          if j+1 < @width
            queue.push([i,j+1])
          end
        end
      end
    end
    group_peremeter = (group_area * 4) - ((group_area-2)*4)
    per = find_perimeter(group_coords.uniq)
    @sums.push(group_area * ((group_area * 4) - (per)))
  end

  def calculate_price
    sum = 0

    for s in @sums
      sum += s
    end

    return sum
  end

  def get_coords_around(i,j)
    coords = []

    coords.push([i,j])

    if i-1 >= 0
      coords.push([i-1,j])
    end
    if i+1 < @height
      coords.push([i+1,j])
    end 
    if j-1 >= 0
      coords.push([i,j-1])
    end
    if j+1 < @width
      coords.push([i,j+1])
    end
    return coords
  end 

  def find_perimeter(vertices)
    perimeter = 0
    adjacent_sides_count = 0

    for i in 0..vertices.length-1
      for j in 0..vertices.length-1
        if i != j
          if (vertices[i][0] == vertices[j][0] && vertices[i][1] == vertices[j][1]-1) || 
            (vertices[i][0] == vertices[j][0] && vertices[i][1] == vertices[j][1]+1) || 
            (vertices[i][0] == vertices[j][0]-1 && vertices[i][1] == vertices[j][1]) || 
            (vertices[i][0] == vertices[j][0]+1 && vertices[i][1] == vertices[j][1]) 
            adjacent_sides_count += 1
          end
        end 
      end
      
    end 
    return adjacent_sides_count
  end
end


day12 = Day12.new()
day12.read_file
puts day12.find_groups
puts day12.calculate_price