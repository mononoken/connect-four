# frozen_string_literal: true

require_relative '../lib/column'

# rubocop:disable Metrics/BlockLength

describe Column do
  describe '#drop' do
    context 'when column is empty' do
      subject(:new_column) { described_class.new }
      it "changes first value of the column's spaces to the mark" do
        one_template = ['x', nil, nil, nil, nil, nil]
        mark = 'x'
        expect { new_column.drop(mark) }
          .to change { new_column.spaces }
          .to(one_template)
      end
    end

    context 'when column already has some marks' do
      subject(:partial_column) { described_class.new(partial_template) }
      let(:partial_template) { ['o', 'x', nil, nil, nil, nil] }
      it "changes the next nil value of the column's spaces to the mark" do
        filled_template = ['o', 'x', 'o', nil, nil, nil]
        mark = 'o'
        expect { partial_column.drop(mark) }
          .to change { partial_column.spaces }
          .to(filled_template)
      end
    end

    context 'when column is already full' do
      subject(:full_column) { described_class.new(full_template) }
      let(:full_template) { ['x', 'o', 'x', 'o', 'x', 'x'] }

      it "does not change column's spaces values" do
        expect { full_column.drop('x') }
          .not_to change { full_column.spaces }
      end
    end
  end
end

# rubocop:enable Metrics/BlockLength
