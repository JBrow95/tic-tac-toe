require_relative 'board.rb'
require_relative 'player.rb'
require_relative 'game.rb'
require_relative 'Computer.rb'
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
    end

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
        @b = Board.new
      
        n = @b.update_board(1,"X")
        q = @b.update_board(5,"O")
        w = @b.update_board(2,"X")
        e = @b.update_board(3,"O")
        r = @b.update_board(7,"X")
        t = @b.update_board(4,"O")
        y = @b.update_board(6,"X")
        u = @b.update_board(8,"O")
        i = @b.update_board(9,"X")

        assert_equal @b.available_options(1), false
        assert_equal @b.available_options(2), false
        assert_equal @b.available_options(3), false
        assert_equal @b.available_options(4), false
        assert_equal @b.available_options(5), false
        assert_equal @b.available_options(6), false
        assert_equal @b.available_options(7), false
        assert_equal @b.available_options(8), false
        assert_equal @b.available_options(9), false
    end

    def test_if_win_combo_works_when_char_is_3_in_a_row
        @c = Board.new
        n = @c.update_board(1,"X")
        q = @c.update_board(4,"O")
        n = @c.update_board(2,"X")
        q = @c.update_board(5,"O")
        n = @c.update_board(3,"X")
        
        assert_equal @c.check_win("X"), true
    end

    def test_if_player_class_holds_name
        n = Player.new("John","X")
        assert_equal n.name, "John"
        assert_equal n.char, "X"
    end

    def test_win_possiblities
        v = Board.new
        c = v.update_board(1,"X")
        c = v.update_board(2,"X")
        c = v.update_board(3,"X")

        b = Board.new
        c = b.update_board(4,"X")
        c = b.update_board(5,"X")
        c = b.update_board(6,"X")   
        
        c = Board.new
        a = c.update_board(7,"X")
        a = c.update_board(8,"X")
        a = c.update_board(9,"X")  
        
        d = Board.new
        q = d.update_board(1,"X")
        q = d.update_board(4,"X")
        q = d.update_board(7,"X")

        e = Board.new
        q = e.update_board(3,"X")
        q = e.update_board(6,"X")
        q = e.update_board(9,"X")

        f = Board.new
        q = f.update_board(1,"X")
        q = f.update_board(5,"X")
        q = f.update_board(9,"X")

        g = Board.new
        q = g.update_board(3,"X")
        q = g.update_board(5,"X")
        q = g.update_board(7,"X")

        assert_equal v.check_win("X"), true
        assert_equal b.check_win("X"), true
        assert_equal c.check_win("X"), true
        assert_equal d.check_win("X"), true
        assert_equal e.check_win("X"), true
        assert_equal f.check_win("X"), true
        assert_equal g.check_win("X"), true
    end

    def test_if_random_computer_takes_random_spot
        v = RandomComp.new

    end
end