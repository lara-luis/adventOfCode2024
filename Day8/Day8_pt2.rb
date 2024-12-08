class Day8
  def initialize()
    @signals = Hash.new { |hash, key| hash[key] = [] }
    @height = 0
    @width = 0
  end

  def read_process_input
    File.open("Day8\\input8.txt", "r") do |f|
      f.each_line.with_index do |line, i|
        @height += 1
        @width = line.length
        chars = line.chars
        for j in 0..chars.length-1
          if chars[j] != '.' && chars[j] != "\n"
            if @signals.key?(chars[j])
              coords = @signals[chars[j]]
              coords.push([i,j]) 
              @signals[chars[j]] = coords
            elsif
              coords = [[i,j]]
              @signals[chars[j]] = coords
            end
          end
      end
    end
  end
end

  def iterate_signals_and_generate_antinodes
    potential_antinodes = [] 
    
    for key in @signals.keys
      signal_values = @signals[key]
      combinations = generate_signal_pairs(signal_values)
      for pairs in combinations
        pair_1 = pairs[0]
        pair_2 = pairs[1]

        distance_i = (pair_1[0] - pair_2[0]).abs
        distance_j = (pair_1[1] - pair_2[1]).abs

        before_node_i = 0
        after_node_i = 0
        before_node_j = 0 
        after_node_j = 0

        list_is = []
        list_js  = []

        potential_antinodes.push(pair_1)
        potential_antinodes.push(pair_2)

        if pair_1[0] < pair_2[0]
          before_node_i = pair_1[0] - distance_i
          after_node_i = pair_2[0] + distance_i

          if pair_1[1] < pair_2[1]
            before_node_j = pair_1[1] - distance_j
            after_node_j = pair_2[1] + distance_j

            while before_node_i >= 0 && before_node_j >= 0
              potential_antinodes.push([before_node_i, before_node_j])
              before_node_i -= distance_i
              before_node_j -= distance_j
            end
            while after_node_i < @height && after_node_j < @width
              potential_antinodes.push([after_node_i, after_node_j])
              after_node_i += distance_i
              after_node_j += distance_j
            end

            
          elsif pair_1[1] > pair_2[1]
            before_node_j = pair_1[1] + distance_j
            after_node_j = pair_2[1] - distance_j
            
            while before_node_i >= 0 && before_node_j >= 0
              potential_antinodes.push([before_node_i, before_node_j])
              before_node_i -= distance_i
              before_node_j += distance_j
            end
            while after_node_i < @height && after_node_j < @width
              potential_antinodes.push([after_node_i, after_node_j])
              after_node_i += distance_i
              after_node_j -= distance_j
            end
          end

        elsif pair_1[0] > pair_2[0]
          before_node_i = pair_2[0] + distance_i
          after_node_i = pair_1[0] - distance_i

          if pair_1[1] < pair_2[1]
            before_node_j = pair_1[1] - distance_j
            after_node_j = pair_2[1] + distance_j

            while before_node_i < @height && before_node_j >= 0
              potential_antinodes.push([before_node_i, before_node_j])
              before_node_i += distance_i
              before_node_j -= distance_j
            end
            while after_node_i >= 0 && after_node_j < @width
              potential_antinodes.push([after_node_i, after_node_j])
              after_node_i -= distance_i
              after_node_j += distance_j
            end

            
          elsif pair_1[1] > pair_2[1]
            before_node_j = pair_1[1] + distance_j
            after_node_j = pair_2[1] - distance_j
            
            while before_node_i <= @height && before_node_j < @width
              potential_antinodes.push([before_node_i, before_node_j])
              before_node_i += distance_i
              before_node_j += distance_j
            end
            while after_node_i >= 0 && after_node_j >= 0
              potential_antinodes.push([after_node_i, after_node_j])
              after_node_i -= distance_i
              after_node_j -= distance_j
            end
          end
        end

      end
    end
    
    return potential_antinodes
  end

  def generate_signal_pairs(signal_values)
    pairs = signal_values.combination(2).to_a
    return pairs
  end

  def filter_antinodes_inside_grid(antinodes)
    filtered_nodes = []

    for antinode in antinodes
      if antinode[0] < 0 || antinode[1] < 0 || antinode[0] >= @height || antinode[1] >= @width
        #puts "Antinode outside grid"
      else
        filtered_nodes.push(antinode)
      end
    end
  
    return filtered_nodes
  end
end


day8 = Day8.new()
day8.read_process_input
antinodes = day8.iterate_signals_and_generate_antinodes
puts day8.filter_antinodes_inside_grid(antinodes).uniq.length