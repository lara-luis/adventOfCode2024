class Day4
  def initialize()
    @as_hash = Hash.new
  end

  def read
    matrix = []

    File.open("Day4\\input4.txt", "r") do |f|
      f.each_line.with_index do |line, i|
        matrix[i] = line.chars
      end
    end
    return matrix
  end

  def process_matrix(matrix)
    count = 0

    matrix.each_with_index do |row, i|
      row.each_with_index do |col, j|
        if matrix[i][j] == 'M'
          count += collect_As_indexes(matrix, i, j)
        end
      end
    end

    return count
  end

  def collect_As_indexes(matrix, i, j)
    count = 0

    if matrix[i+1] != nil && matrix[i+1][j-1] != nil && matrix[i+2] != nil && matrix[i+2][j-2] != nil && j-2 > -1
      if matrix[i+1][j-1] == 'A' && matrix[i+2][j-2] == 'S'
        if @as_hash.key?([i+1,j-1])
          count += 1 
          @as_hash[[i+1,j-1]] += 1
        elsif
          @as_hash[[i+1,j-1]] = 1
        end
      end
    end 

    if matrix[i-1] != nil && matrix[i-1][j+1] != nil && matrix[i-2] != nil && matrix[i-2][j+2] != nil && i-2 > -1
      if matrix[i-1][j+1] == 'A' && matrix[i-2][j+2] == 'S'
        if @as_hash.key?([i-1,j+1])
          count += 1 
          @as_hash[[i-1,j+1]] += 1
        elsif
          @as_hash[[i-1,j+1]] = 1
        end
      end
    end 

    if matrix[i+1] != nil && matrix[i+1][j+1] != nil && matrix[i+2] != nil && matrix[i+2][j+2] != nil
      if matrix[i+1][j+1] == 'A' && matrix[i+2][j+2] == 'S'
        if @as_hash.key?([i+1,j+1])
          count += 1 
          @as_hash[[i+1,j+1]] += 1
        elsif
          @as_hash[[i+1,j+1]] = 1
        end
      end
    end 

    if matrix[i-1] != nil && matrix[i-1][j-1] != nil && matrix[i-2] != nil && matrix[i-2][j-2] != nil && i-2 > -1 && j-2 > -1
      if matrix[i-1][j-1] == 'A' && matrix[i-2][j-2] == 'S'
        if @as_hash.key?([i-1,j-1])
          count += 1 
          @as_hash[[i-1,j-1]] += 1
        elsif
          @as_hash[[i-1,j-1]] = 1
        end
      end
    end 

    return count
  end

end

day4 = Day4.new()
matrix = day4.read
puts day4.process_matrix(matrix)