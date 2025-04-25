class StringCalculator
  class << self
    def add(string)
      parser = StringParser.new(string)
      numbers = parser.parse
      Validator.validate(numbers)
      numbers.select { |num| num <= 1000 }.sum
    end
  end
end

class StringParser
  def initialize(string)
    @string = string
  end

  def parse
    return [] if @string.empty?

    delimiter, numbers_string = extract_delimiter_and_numbers
    numbers_string.split(delimiter).map(&:to_i)
  end

  private

  def extract_delimiter_and_numbers
    delimiter = /[\n,]/
    if @string.start_with?('//')
      delimiter_part, numbers_part = @string.split("\n", 2)
      custom_delimiters = delimiter_part[2..].scan(/\[(.*?)\]/).flatten

      delimiter = if custom_delimiters.any?
                    Regexp.union(custom_delimiters)
                  else
                    Regexp.new(Regexp.escape(delimiter_part[2..]))
                  end
      return delimiter, numbers_part
    end
    [delimiter, @string]
  end
end

class Validator
  def self.validate(numbers)
    negatives = numbers.select(&:negative?)
    raise "negative numbers not allowed #{negatives.join(',')}" if negatives.any?
  end
end
