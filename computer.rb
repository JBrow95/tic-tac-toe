class PlayerComp
    
    attr_accessor :name, :char
    load 'player.rb'
    load 'board.rb'

    def initialize
        @c = Board.new
        @c_arr = []
    end

    def get_name
        @player1 = Player.new('Player', "X")
		@player2 = Player.new('Tom', "O")
    end


    def play_move(player)
        puts "\n#{player.name} Your Turn: #{player.char}." 
        choice = gets.chomp
        @c_arr << choice
        
        print "#{@c_arr}\n\n"
        char = player.char
        return choice, char
    end

    def cpu_move(player)
        puts "\n#{player.name} Your Turn: #{player.char}." 
        sleep 1
        choice_array = [1,2,3,4,5,6,7,8,9]
        choice_array.shuffle!
        choice = choice_array.pop
        char = player.char
        return choice, char
    end

    def random_cpu
        count = 0
        marker = nil
        win_flag = false
        @c.draw_board
        while count < 9

                if count % 2 ==0
                    marker = @player1
                    char = "X"
                else
                    marker = @player2
                    char ="O"
                end
                if marker == @player2
            var1, var2 = cpu_move(marker)
                else
            var1, var2 = play_move(marker)
                end
            update = @c.update_board(var1.to_i,var2)
            if update == false #stops extra counts 
                count == count
            else
            checking_win = @c.check_win(char)
            if checking_win == true
                win(marker)
            else
                count += 1
                if count == 9
                    puts "Game is a draw"
                    win("draw")
                end
            end
            end

        end
    end

    
end