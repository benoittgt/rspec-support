# encoding: utf-8
require 'spec_helper'
# require 'ostruct'
# require 'timeout'
# require 'rspec/support/spec/string_matcher'
require 'rspec/support/diff_object_formater'

module RSpec
  module Support
    describe DiffObjectFormater do
      describe '#ellipsed_diff' do
        let(:diff_object_formater) { RSpec::Support::DiffObjectFormater.new }

        skip it "outputs unified diff of two strings" do
          expected = "ABCDEFGHIJKLMOPQRSTUV"
          actual   = "ABCDEFGHI___MOPQRSTUV"

          diff_object_formater.ellipsed_diff(actual, expected)
          expect(diff_object_formater.ellipsed_diff(actual, expected)).to eq(<<-'EOS')
            |
            | 345345
            |
          EOS
        end
      end
    end
  end
end
