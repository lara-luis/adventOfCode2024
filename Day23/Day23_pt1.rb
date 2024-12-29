class Day23
  def initialize()
    @network = Hash.new
  end

  def read_process_input
    File.open("Day23\\input23.txt", "r") do |f|
      f.each_line.with_index do |line, i|
        computers = line.gsub("\n","").split("-")

        if !@network.key?(computers[0])
          @network[computers[0]] = []
        end 

        if !@network.key?(computers[1])
          @network[computers[1]] = []
        end

        @network[computers[0]].push(computers[1])
        @network[computers[1]].push(computers[0])
      end
    end
  end

  def find_groups
    relevant_grops = Set.new
    visited = []

    for key in @network.keys
      if !visited.include?(key)
        other_computers = @network[key]
        visited.push(key)
        if other_computers.length >= 2
          for i in 0..other_computers.length-1
            other_computer_network = @network[other_computers[i]]
            common_computers = other_computers & other_computer_network
            if common_computers.length > 0
              for j in 0..common_computers.length-1
                last_computer_network = @network[common_computers[j]]
                if last_computer_network.include?(key) && 
                  last_computer_network.include?(other_computers[i])
                  if key.start_with?("t") || common_computers[j].start_with?("t") ||
                    other_computers[i].start_with?("t")
                    relevant_grops.add([key, other_computers[i], common_computers[j]].sort)
                  end
                end
              end
            end 
          end
        end
      end
    end
    return relevant_grops.length
  end
end


day23 = Day23.new()
day23.read_process_input
puts day23.find_groups