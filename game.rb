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
		      count += 1
		      if count == 9
		  	    puts "Game is a draw"
			  end
			end
		end
	end

end

	# new_game = PvP.new
	
	# puts "Choose Game mode [CvC] [PvP] [CvP]"
	# response = gets.chomp
	# 	case response.downcase
	# 	when "pvp"
	# 		new_game.names
	# 		new_game.pvp
	# 	end