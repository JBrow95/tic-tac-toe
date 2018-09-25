require_relative 'board.rb'
require 'test/unit'

class TestUntitled < Test::Unit::TestCase

    def test_if_board_is_array
        @board = [1,2,3,4,5,6,7,8,9]
        @wins_combo = [[0,3,6],[1,4,7],[2,5,8],[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6]]
        assert_equal Array, @board.class
        assert_equal Array, @wins_combo.class
    end

    def test_if_draw_board_has_9_positions
        c = Board.new
        assert_equal c.draw_board.length, 9
    end

    def test_if_board_resets
        c = Board.new
        assert_equal c.reset_board, [1,2,3,4,5,6,7,8,9]
    end
end