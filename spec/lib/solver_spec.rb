# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Solver do
  let(:attempts) do
    [
      [["т", "grey"], ["а", "yellow"], ["л", "grey"], ["ь", "grey"], ["к", "grey"]],
      [["б", "grey"], ["а", "yellow"], ["г", "white"], ["а", "grey"], ["ж", "grey"]],
      [["г", "yellow"], ["а", "yellow"], ["р", "grey"], ["е", "grey"], ["м", "grey"]],
      [["п", "grey"], ["и", "grey"], ["а", "white"], ["н", "white"], ["о", "white"]],
      [["а", "white"], ["н", "grey"], ["и", "grey"], ["о", "yellow"], ["н", "yellow"]]
    ]
  end

  let(:solver) { described_class.new }

  it 'calculates the correct answer' do
    result = nil
    attempts.each { |attempt| result = solver.add_attempt(attempt) }

    expect(result).to include('газон')
  end
end
