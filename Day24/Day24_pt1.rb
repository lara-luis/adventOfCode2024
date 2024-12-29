class Day24
  def initialize()
    @inputs = Hash.new
    @operators_queue = [] # (var, op, var, output)
  end

  def read_process_input
    File.open("Day24\\input24.txt", "r") do |f|
      f.each_line.with_index do |line, i|
        if line.include?(":")
          line = line.split(":")
          @inputs[line[0]] = line[1].strip.to_i
        elsif !line.strip.empty?
          if line.include?("AND")
            op = line.split("AND")
            tmp = op[1].split("->")
            @operators_queue.push([op[0].strip, "AND", tmp[0].strip, tmp[1].strip])
          elsif line.include?("XOR")
            op = line.split("XOR")
            tmp = op[1].split("->")
            @operators_queue.push([op[0].strip, "XOR", tmp[0].strip, tmp[1].strip])
          elsif line.include?("OR")
            op = line.split("OR")
            tmp = op[1].split("->")
            @operators_queue.push([op[0].strip, "OR", tmp[0].strip, tmp[1].strip])
          end
        end 
      end
    end
  end

  def calculate
    @operators_queue.each { |op_combination|
      var1 = op_combination[0]
      op = op_combination[1]
      var2 = op_combination[2]
      output = op_combination[3]

      if @inputs.key?(var1) && @inputs.key?(var2)
        if op == "AND"
          @inputs[output] = @inputs[var1] & @inputs[var2]
        elsif op == "OR"
          @inputs[output] = @inputs[var1] | @inputs[var2]
        elsif op == "XOR"
          @inputs[output] = @inputs[var1] ^ @inputs[var2]
        end
      else
        @operators_queue.push([var1, op, var2, output])
      end
    }

    first_output = @inputs["z00"]
    incr = 0
    res = ""
    while first_output != nil
      res += first_output.to_s
      incr += 1
      incr_string = incr.to_s
      if incr_string.size == 1 
        incr_string = "0" + incr_string
      end 
      incr_string = "z" + incr_string
      first_output = @inputs[incr_string]
    end

    return res.reverse!.to_i(2)
  end
end


day24 = Day24.new()
day24.read_process_input
puts day24.calculate