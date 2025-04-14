class StringCalculator
  def self.add(string)
    0 if string.empty?
    if string.start_with?("//")
      delimiter = string[2]
      string = string[4..-1]
    else
      delimiter = /[\n,]/
    end
    numbers = string.split(delimiter)
    if numbers.any? { |num| num.to_i.negative? }
      negatives = numbers.select { |num| num.to_i.negative? }
      raise "negative numbers not allowed #{negatives.join(',')}"
    end

    numbers.map(&:to_i).sum
  end
end