class Solver
  attr_accessor :words_possible, :attempts, :guessed_letters

  def initialize
    self.words_possible = (DictionaryService::Import.dataset.presence || DictionaryService::Import.run).dup
    self.attempts = []
    self.guessed_letters = {}
  end

  def add_attempt(letters)
    attempt = Attempt.new(letters)
    return :invalid_attempt unless attempt.valid?

    self.attempts << attempt
    exclude_words(attempt)
    words_possible.sample(5)
  end

  def exclude_words(attempt)
    new_words = words_possible

    possible_letters = {}
    excess_letters = {}

    attempt.letters.each.with_index do |(letter, mark), index|
      if mark == :yellow
        self.guessed_letters[letter] ||= [index]
        self.guessed_letters[letter] << index unless guessed_letters[letter].include?(index)
      end
    end

    attempt.letters.each.with_index do |(letter, mark), index|
      if mark == :white
        possible_letters[letter] ||= [index]
        possible_letters[letter] << index unless possible_letters[letter].include?(index)
      end
    end

    attempt.letters.each.with_index do |(letter, mark), _index|
      if mark == :grey && (guessed_letters[letter].present? || possible_letters[letter].present?)
        excess_letters[letter] = (guessed_letters[letter] || []).size + (possible_letters[letter] || []).size
      end
    end

    attempt.letters.each.with_index do |(letter, mark), index|
      new_words = new_words.delete_if do |word|
        case mark
        when :yellow
          word[index] != letter
        when :white
          word[index] == letter ||
            word.index(letter).nil? ||
            !guessed_letters[letter].nil? &&
            ((0...word.length).find_all { |i| word[i,1] == letter } - guessed_letters[letter]).empty?
        when :grey
          excess_letters[letter].nil? && word.index(letter).present? ||
            excess_letters[letter].present? && (
              word[index] == letter ||
                (0...word.length).find_all { |i| word[i,1] == letter }.size > excess_letters[letter].size
            )
        else
          false
        end
      end
    end

    self.words_possible = new_words
  end
end