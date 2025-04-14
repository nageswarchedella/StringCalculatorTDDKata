class StringCalculator
  def self.add(string)
    return 0 if string.empty?

    delimiter = '\n,'
    if string.start_with?('//')
      delimiter = string.split(' ')[0][2..].split(/[\[\]]/).join('')
      string = string.split(' ')[1]
    end
    numbers = string.split(/[#{delimiter}]/).map(&:to_i)
    if numbers.any?(&:negative?)
      negatives = numbers.select(&:negative?)
      raise "negative numbers not allowed #{negatives.join(',')}"
    end

    numbers.select { |num| num <= 1000 }.sum
  end
end
