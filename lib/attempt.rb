class Attempt
  attr_accessor :letters

  def initialize(letters)
    self.letters = letters
  end

  def valid?
    return false if letters&.size != 5

    letters.all? do
      letter = _1.first
      mark = _1.second
      letter.is_a?(String) && letter.size == 1 && %i[grey white yellow].include?(mark)
    end
  end
end