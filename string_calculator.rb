class StringCalculator
  def self.add(string)
    0 if string.empty?
    string.split(',').map(&:to_i).sum
  end
end