class Day7
  def initialize()
    
  end

  def read_process_input
    sum = 0

    File.open("Day7\\input7.txt", "r") do |f|
      f.each_line do |line|
        target_val = line[0..line.index(':')-1]
        other_values = line[line.index(':')+1..line.length]
        sums_up = process_line(target_val, other_values)
        if sums_up
          sum += target_val.to_i
        end
      end
    end
    puts sum
  end

  def process_line(target, values)
    output = values.strip.gsub(/ /, '+')
    all_indexes = (0 ... output.length).find_all { |i| output[i,1] == '+' }
    if evaluate_expression(output) == target 
      return true
    end

    alternatives = generate_combinations(all_indexes.length)

    for alternative in alternatives
      combination = output
      for i in 0..all_indexes.length-1  
        combination[all_indexes[i]] = '*' if alternative[i] == 1
        combination[all_indexes[i]] = '+' if alternative[i] == 2
        combination[all_indexes[i]] = '|' if alternative[i] == 3
      end 

      res = evaluate_expression(combination).to_i
      if res.to_i == target.to_i
        return true
      end
    end
    return false
  end

   # thanks copilot
  def generate_combinations(n)
    values = [1,2,3]
    return [[]] if n == 0
  
    # Recursive step: Combine each value with smaller combinations
    smaller_combinations = generate_combinations(n - 1)
    values.flat_map do |value|
      smaller_combinations.map { |combination| [value] + combination }
    end
  end
end

# thanks chatgpt
def evaluate_expression(expression)
  tokens = expression.scan(/(\d+|\+|\-|\*|\||\/)/)
  result = tokens.shift[0].to_i

  while tokens.any?
    operator = tokens.shift[0]
    operand = tokens.shift[0].to_i

    case operator
    when '+'
      result += operand
    when '-'
      result -= operand
    when '*'
      result *= operand
    when '/'
      result /= operand
    when '|'
      result = (result.to_s + operand.to_s).to_i
    end
  end

  result
end

day7 = Day7.new()
puts day7.read_process_input