class PlayerComp
    
    attr_accessor :name, :char, :c_arr, :c
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

    def s_move(player)
        puts "\n#{player.name} Your Turn: #{player.char}." 
        sleep 1 
        choice = 0
        until @c.available_options(choice) == true
            choice += 1
        end
        puts choice
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

    def seq_cpu
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
            var1, var2 = s_move(marker)
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

    def win(player)
		if player =="draw"
			puts "Game was a draw."
		else
		  puts "#{player.name} WINS! \nWhat a Battle!"
		end
		puts "Press Y to play again, or any other key to quit."
		answer = gets.chomp.capitalize
			if answer == "Y"
				puts "\n\nThe Board has been reset!"
				@c = Board.new
                @c.reset_board
                @c.draw_board
			else
				abort ("Thanks for Playing!")
			end
        end

        def h_move(player)
            puts "\n#{player.name} Your Turn: #{player.char}." 
            sleep 1 
        
            wins_game = [[1,2,3],[7,4,1],[5,2,8],[7,1,4],[9,7,8],[7,9,8],[1,3,2],[5,3,7],[3,6,9],[3,9,6],[9,6,3],[5,4,6],[5,6,4],[5,8,2],[9,3,6],[8,5,2],[6,5,4],[4,5,6],[7,8,9],[9,8,7],[8,9,7],[1,4,7],[2,5,8],[1,5,9],[3,5,7],[1,7,4],[7,5,3],[6,7,8],[2,9,6],[8,1,4],[3,8,6],[4,6,2],[6,8,1],[3,7,6],[7,3,4],[1,3,4],[1,8,4]]
            middle_corner = [[1, 5, 7], [3, 5, 9], [7, 5, 9], [9, 5, 3],[1,9,4],[6,1,3]]

            if @c_arr.include?("5") == false && @c.available_options(5) == true
                choice = 5
            end
            
            middle_corner.each do |m|
                if @c_arr.include?(m[0].to_s) && @c_arr.include?(m[1].to_s) && @c.board.include?(m[2]) == true
                    choice = m[2]
                    break
                end
            end
            
             wins_game.each do |n|
                 if @c_arr.include?(n[0].to_s) == true && @c_arr.include?(n[1].to_s) == true  && @c.board.include?(n[2]) == true
                     choice = n[2]
                     break
                end
            end

            
            wins_game.each do |c|
                if @c_arr.include?(c[0].to_s) == false && @c_arr.include?(c[1].to_s) == false  && @c.board.include?(c[0]) == false && @c.board.include?(c[1]) == false && @c.board.include?(c[2]) == true
                    choice = c[2]
                    break
                end
            end

            
            stuff = [1,2,3,4,5,6,7,8,9]
            if choice == nil
               stuff.each do |x|
                if @c.board.include?(x) == true
                    choice = x
                    break
                end
               end
            end
        
           
            puts choice
            char = player.char
            return choice, char
        end
    

        def hard_cpu
            @count = 0
            marker = nil
            win_flag = false
            @c.draw_board
            while @count < 9
    
                    if @count % 2 ==0
                        marker = @player1
                        char = "X"
                    else
                        marker = @player2
                        char ="O"
                    end
                    if marker == @player2
                        var1, var2 = h_move(marker)
                            else
                        var1, var2 = play_move(marker)
                            end
                # var1, var2 = h_move(marker)
                update = @c.update_board(var1.to_i,var2)
                if update == false #stops extra counts 
                    @count == @count
                else
                checking_win = @c.check_win(char)
                if checking_win == true
                    win(marker)
                else
                    @count += 1
                    if @count == 9
                        puts "Game is a draw"
                        win("draw")
                    end
                end
                end
    
            end
        end
    
        def win(player)
            if player =="draw"
                puts "Game was a draw."
            else
              puts "#{player.name} WINS! \nWhat a Battle!"
            end
            puts "Press Y to play again, or any other key to quit."
            answer = gets.chomp.capitalize
                if answer == "Y"
                    puts "\n\nThe Board has been reset!"
                    @c = Board.new
                    @c.reset_board
                    @c.draw_board
                else
                    abort ("Thanks for Playing!")
                end
            end
    
end