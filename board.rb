class Board
	attr_accessor :moves_taken, :win, :board
	def initialize
		@board = @board = [1,2,3,4,5,6,7,8,9]
		@wins_combo = [[0,3,6],[1,4,7],[2,5,8],[0,1,2],[3,4,5],[6,7,8],[0,4,8],[2,4,6]]
		@win = false
		@moves_taken = 0
	end

	def draw_board
		@board.each_with_index do |x,i| 
			print "| #{x} |" unless (i + 1) % 3 == 0
			if (i + 1) % 3 == 0
			print	x = "| #{x} |\n\n"
			end
		end
	end

	def reset_board
		@board = @board = [1,2,3,4,5,6,7,8,9]
	end

	def update_board(choice,char)
		@moves_taken += 1
		x = available_options(choice)
		if x == true
			@board[choice -1] = char
			return draw_board
			#check_win(char)
		else
			return false
		end
	end

	def check_win(char)
		results = []
		@wins_combo.each do |set|
		  set.map do |i|
		    if @board[i] == char
              results.push(@board[i])
			end
		  end
		    check_results(results,char)
		   
			results = []
			if @win == true
			  return @win
			end
		end
	end


	def check_results(results,char)
		 if results[0..2] == [char,char,char]
		 	@win = true
			 results = results.clear
		 end
		 
	end

	def available_options(choice)
		@board.include?(choice)
	end

	attr_reader :board
end



