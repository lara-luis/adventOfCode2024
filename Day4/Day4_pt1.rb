class Day4
  def initialize()

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
        if matrix[i][j] == 'X'
          count += count_words(matrix, i, j)
        end
      end
    end
    return count
  end

  def count_words(matrix, i, j)
    word_count = 0

    if matrix[i+1] != nil && matrix[i+1][j] != nil && matrix[i+2] != nil && matrix[i+2][j] != nil && matrix[i+3] != nil && matrix[i+3][j] != nil
      if matrix[i+1][j] == 'M' && matrix[i+2][j] == 'A' && matrix[i+3][j] == 'S'
        word_count += 1 
      end
    end 

    if matrix[i-1] != nil && matrix[i-1][j] != nil && matrix[i-2] != nil && matrix[i-2][j] != nil && matrix[i-3] != nil && matrix[i-3][j] != nil && i-3 > -1
      if matrix[i-1][j] == 'M' && matrix[i-2][j] == 'A' && matrix[i-3][j] == 'S'
        word_count += 1
      end
    end 

    if matrix[i] != nil && matrix[i][j+1] != nil && matrix[i] != nil && matrix[i][j+2] != nil && matrix[i] != nil && matrix[i][j+3] != nil
      if matrix[i][j+1] == 'M' && matrix[i][j+2] == 'A' && matrix[i][j+3] == 'S'
        word_count += 1 
      end
    end 

    if matrix[i] != nil && matrix[i][j-1] != nil && matrix[i][j-2] != nil && matrix[i][j-3] != nil
      if matrix[i][j-1] == 'M' && matrix[i][j-2] == 'A' && matrix[i][j-3] == 'S' && j-3 > -1
        word_count += 1
      end
    end 

    if matrix[i+1] != nil && matrix[i+1][j-1] != nil && matrix[i+2] != nil && matrix[i+2][j-2] != nil && matrix[i+3] != nil && matrix[i+3][j-3] != nil && j-3 > -1
      if matrix[i+1][j-1] == 'M' && matrix[i+2][j-2] == 'A' && matrix[i+3][j-3] == 'S'
        word_count += 1
      end
    end 

    if matrix[i-1] != nil && matrix[i-1][j+1] != nil && matrix[i-2] != nil && matrix[i-2][j+2] != nil && matrix[i-3] != nil && matrix[i-3][j+3] != nil && i-3 > -1
      if matrix[i-1][j+1] == 'M' && matrix[i-2][j+2] == 'A' && matrix[i-3][j+3] == 'S'
        word_count += 1
      end
    end 

    if matrix[i+1] != nil && matrix[i+1][j+1] != nil && matrix[i+2] != nil && matrix[i+2][j+2] != nil && matrix[i+3] != nil && matrix[i+3][j+3] != nil
      if matrix[i+1][j+1] == 'M' && matrix[i+2][j+2] == 'A' && matrix[i+3][j+3] == 'S'
        word_count += 1
      end
    end 

    if matrix[i-1] != nil && matrix[i-1][j-1] != nil && matrix[i-2] != nil && matrix[i-2][j-2] != nil && matrix[i-3] != nil && matrix[i-3][j-3] != nil && i-3 > -1 && j-3 > -1
      if matrix[i-1][j-1] == 'M' && matrix[i-2][j-2] == 'A' && matrix[i-3][j-3] == 'S'
        word_count += 1
      end
    end 

    return word_count
  end

end

day4 = Day4.new()
matrix = day4.read
puts day4.process_matrix(matrix)