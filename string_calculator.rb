class StringCalculator
  def self.add(string)
    0 if string.empty?
    if string.start_with?("//")
      delimiter = string[2]
      string = string[4..-1]
    else
      delimiter = /[\n,]/
    end
    string.split(delimiter).map(&:to_i).sum
  end
end