require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'game.rb'
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

    def test_if_get_name_gets_name_from_class_player_and_character
        n = Player.new("John","X")
        b = Player.new("Tom","O")
        assert_equal n.name, "John"
        assert_equal n.char, "X"
        assert_equal b.name, "Tom"
        assert_equal b.char, "O"
 0 end

    def test_if_the_board_puts_chars_in_open_spots_and_cant_choose_the_same_spot
        @c = Board.new
        n = @c.update_board(5,"X")
        b = @c.update_board(6,"O")
        assert_equal @c.available_options(1), true
        assert_equal @c.available_options(2), true
        assert_equal @c.available_options(3), true
        assert_equal @c.available_options(4), true
        assert_equal @c.available_options(5), false
        assert_equal @c.available_options(6), false
        assert_equal @c.available_options(7), true
        assert_equal @c.available_options(8), true
        assert_equal @c.available_options(9), true
    end

    def test_if_no_options_are_available_game_draws
        @c = Board.new
        n = @c.update_board(1,"X")
        q = @c.update_board(5,"O")
        w = @c.update_board(2,"X")
        e = @c.update_board(3,"O")
        r = @c.update_board(7,"X")
        t = @c.update_board(4,"O")
        y = @c.update_board(6,"X")
        u = @c.update_board(8,"O")
        i = @c.update_board(9,"X")

        
        assert_equal @c.available_options(1), false
        assert_equal @c.available_options(2), false
        assert_equal @c.available_options(3), false
        assert_equal @c.available_options(4), false
        assert_equal @c.available_options(5), false
        assert_equal @c.available_options(6), false
        assert_equal @c.available_options(7), false
        assert_equal @c.available_options(8), false
        assert_equal @c.available_options(9), false


    end
end