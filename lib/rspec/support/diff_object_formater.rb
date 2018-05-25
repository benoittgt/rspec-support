module RSpec
  module Support
    # Help format long ouput for ObjectFormatter
    class DiffObjectFormater
      attr_accessor :diff_intro, :diff_outro, :received_diff_part, :expected_diff_part
      INTRO_OUTRO_LENGTH = 3

      def initialize
        @diff_intro = []
        @diff_outro = []
        @received_diff_part = []
        @expected_diff_part = []
      end

      def ellipsed_diff(target, source)
        target = target.split('')
        source = source.split('')

        until source.empty? || target.empty? || output_limit_reached?
          compose_diff_parts(source, target)
        end

        expected = diff_intro_ellipsed + expected_diff_part + diff_outro_ellipsed
        received = diff_intro_ellipsed + received_diff_part + diff_outro_ellipsed

        puts "Expect   : #{expected.join}"
        puts "Received : #{received.join}"
      end

      private

      def compose_diff_parts(source, target)
        first_source_item = source.shift
        first_target_item = target.shift

        if first_source_item == first_target_item
          if expected_diff_part.empty?
            diff_intro << first_source_item
            diff_intro.delete_at(3) if diff_intro.size > 6
          elsif diff_outro.size < 7
            diff_outro << first_source_item
          end
        elsif diff_outro.empty?
          received_diff_part << first_source_item
          expected_diff_part << first_target_item
        end
      end

      def output_limit_reached?
        INTRO_OUTRO_LENGTH + received_diff_part.size + INTRO_OUTRO_LENGTH > 8
      end

      def diff_intro_ellipsed
        return diff_intro unless diff_intro.any? && diff_intro.size > INTRO_OUTRO_LENGTH
        diff_intro[0..2] = ['.','.','.']
        diff_intro
      end

      def diff_outro_ellipsed
        return diff_outro unless diff_outro.any? && diff_outro.size > INTRO_OUTRO_LENGTH
        diff_outro[4..-1] = ['.','.','.']
        diff_outro
      end
    end
  end
end
