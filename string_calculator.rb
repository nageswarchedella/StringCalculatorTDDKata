class StringCalculator
  class << self
    def add(string)
      return 0 if string.empty?

      delimiter, numbers_string = extract_delimiter_and_numbers(string)
      numbers = numbers_string.split(delimiter).map(&:to_i)

      raise_error_if_negatives_present(numbers)

      numbers.select { |num| num <= 1000 }.sum
    end

    def extract_delimiter_and_numbers(string)
      delimiter = /[\n,]/
      if string.start_with?('//')
        delimiter_part, numbers_part = string.split("\n", 2)
        custom_delimiters = delimiter_part[2..].scan(/\[(.*?)\]/).flatten

        delimiter = if custom_delimiters.any?
                      Regexp.union(custom_delimiters)
                    else
                      Regexp.new(Regexp.escape(delimiter_part[2..]))
                    end
        return delimiter, numbers_part
      end
      [delimiter, string]
    end

    def raise_error_if_negatives_present(numbers)
      negatives = numbers.select(&:negative?)
      raise "negative numbers not allowed #{negatives.join(',')}" if negatives.any?
    end
  end
end
