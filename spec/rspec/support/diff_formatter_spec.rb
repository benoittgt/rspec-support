require 'rspec/support/diff_formatter'
require 'rspec/matchers/fail_matchers'

module RSpec
  module Support
    describe DiffFormatter, ".format" do
      context 'with specified max_formatted_output_length' do
        it 'returns ellipsis, intro, diff, outro, ellipsis' do
          formatter = DiffFormatter.new(10)
          expect(formatter.format('aaaaaaaa1234567890bbbbbbbb', 'aaaaaaaa12345___90bbbbbbbb')).to eq(["...34567890bb...", "...345___90bb..."])
        end

        skip it 'does not truncate shorter strings' do
          formatter = DiffFormatter.new(10)
          expect(formatter.format('Testing')).to eq('"Testing"')
        end
      end
    end
  end
end
