class PvP

	attr_accessor :name, :char 
	load 'player.rb'
	load 'board.rb'
	load 'computer.rb'

	def initialize
		@c = Board.new
 	end
	 
	def names
		@player1 = Player.new(get_name(1), "X")
	 	@player2 = Player.new(get_name(2), "O")
	end

	def get_name(x)
		puts "\nHi Player#{x} what is your name: "
		gets.chomp		
	end

	def take_move(player)
		puts "\n#{player.name} Your Turn: #{player.char}." 
		choice = gets.chomp
		char = player.char
		return choice, char
	end

	
	def pvp
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
		  var1, var2 = take_move(marker)
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
		    p count
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
				@c =Board.new
				@c.reset_board
				@c.draw_board
			else
				abort ("Thanks for Playing!")
			end
	end

end

# new_game = PvP.new
# 	game = PlayerComp.new
# 	c = RandomComp.new
# 	puts "Choose Game mode [CvC] [PvP] [CvP]"
# 	response = gets.chomp
# 		case response.downcase
# 		when "cvc" 
# 			puts "Choose mode R[Random] S[Sequential] U[Unbeatable]"
# 			response1 = gets.chomp
# 			case response1.downcase
# 			when 'r'
# 				c.comp_names
# 				c.random
# 			when 's'
# 				c.comp_names
# 				c.seq_cpu
# 			when 'u'
# 				c.comp_names
# 				c.hard
# 			end
# 		when "pvp"
# 			new_game.names
# 			new_game.pvp
# 		when "cvp"
# 			puts "R[Random] S[Sequential] U[Unbeatable]"
# 			response2 = gets.chomp
# 			case response2.downcase
# 			when 'r'
# 				game.get_name
# 				game.random_cpu
# 			when 's'
# 				game.get_name
# 				game.seq_cpu
# 			when 'u'
# 				game.get_name
# 				game.hard_cpu
# 			end
# 		end