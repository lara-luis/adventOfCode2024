class Day22
  def initialize()
    @SECRETS_TO_PREDICT = 2000
  end

  def read_file
    res = 0
    i = 0
    File.open("Day22\\input22.txt", "r") do |f|
      f.each_line.with_index do |line, i|
        if !line.empty?
          secret = line.to_i

          for i in 0..@SECRETS_TO_PREDICT-1
            secret = predict_secret(secret)

            if i == @SECRETS_TO_PREDICT-1
              res += secret
            end
          end 
        end 
      end
    end
    puts res
  end

  def mix(to_mix, secret)
    return to_mix ^ secret
  end

  def prune(number)
    return number % 16777216
  end 

  def predict_secret(secret_number)
    secret = 0
    to_mix = secret_number*64
    secret = mix(to_mix, secret_number)
    secret = prune(secret)

    to_mix = (secret / 32).floor(0)
    secret = mix(to_mix, secret)
    secret = prune(secret)

    to_mix = secret * 2048
    secret = mix(to_mix, secret)
    secret = prune(secret)

    return  secret 
  end
end

day22 = Day22.new()
day22.read_file