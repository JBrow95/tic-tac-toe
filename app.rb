require 'sinatra'
require_relative 'game.rb'
require_relative 'board.rb'

enable :sessions


get '/' do
	erb :dashboard
end

post '/play' do

	redirect '/game'
end

post '/seq' do

	redirect '/seq_game'
end

get '/seq_game' do
	won = session[:won] || false
	session[:board] = session[:board] || Board.new
	session[:pvc] = session[:pvc] || PlayerComp.new
	state = session[:state] || "Lets Play"
	erb :seq_game, locals:{board: session[:board], won: won, state: state}
end

post '/seq_game' do
	pvc = session[:pvc]
	board = session[:board]
	choice = params[:choice]
	session[:won] = "false"
	board.moves_taken = 0
	p choice
	
		if pvc.c.available_options(choice.to_i) == true
		pvc.c.update_board(choice.to_i, "X")
		board.update_board(choice.to_i, "X")
		pvc.c_arr << choice
		print pvc.c_arr
		print board.board
		board.check_win("X")
		if board.win
			session[:state] = "Player Won"
			session[:won] = "true"
			redirect '/seq_game'
		end

	
		var1, var2 = pvc.s_move(Player.new("Tom", "O"))
		pvc.c.update_board(var1.to_i, var2)
		board.update_board(var1.to_i, var2)
		board.check_win("O")
		if board.win
			session[:state] = "Computer Won"
			session[:won] = "true"
			redirect '/seq_game'
		end
	else
		redirect '/seq_game?invalide move!!!'
	end
	if board.moves_taken >= 9
		session[:state] = "Draw"
		redirect '/seq_game'
	end
	redirect '/seq_game'
end

post '/seq_replay' do
	session[:board] = Board.new
	session[:pvc] = PlayerComp.new
	session[:state] = "Lets play"
	session[:won] = "false"
	redirect '/seq_game'
end

get '/game' do
	won = session[:won] || false
	session[:board] = session[:board] || Board.new
	session[:pvc] = session[:pvc] || PlayerComp.new
	state = session[:state] || "Lets Play"
	erb :game, locals:{board: session[:board], state: state, won: won}
end

post '/game' do
	pvc = session[:pvc]
	board = session[:board]
	choice = params[:choice]
	session[:won] = "false"
	board.moves_taken = 0
	p choice

		if pvc.c.available_options(choice.to_i) == true
		pvc.c.update_board(choice.to_i, "X")
		board.update_board(choice.to_i, "X")
		pvc.c_arr << choice
		print pvc.c_arr
		print board.board
		board.check_win("X")
		if board.win
			session[:state] = "Player Won"
			session[:won] = "true"
			redirect '/game'
			
		end

	
		var1, var2 = pvc.h_move(Player.new("Tom", "O"))
		pvc.c.update_board(var1.to_i, var2)
		board.update_board(var1.to_i, var2)
		board.check_win("O")
		if board.win
			session[:state] = "Computer Won"
			session[:won] = "true"
			redirect '/game'
		end
	else
		redirect '/game?invalide move!!!'
	end
	if pvc.c.moves_taken >= 9
		session[:state] = "Draw"
		session[:won] = "true"
		redirect '/game'
	end
	redirect '/game'
end

post '/replay' do
	
	session[:board] = Board.new
	session[:pvc] = PlayerComp.new
	session[:state] = "Lets play"
	session[:won] = "false"
	redirect '/game'
end


#===============Random============================
post '/rand' do

	redirect '/rand_game'
end

get '/rand_game' do
	won = session[:won] || false
	state = session[:state] || "Lets Play"
	session[:board] = session[:board] || Board.new
	session[:pvc] = session[:pvc] || PlayerComp.new
	
	erb :random, locals:{board: session[:board], state: state, won: won}
end

post '/rand_game' do
	pvc = session[:pvc]
	board = session[:board]
	choice = params[:choice]
	session[:won] = "false"
	board.moves_taken = 0
	p choice

		if pvc.c.available_options(choice.to_i) == true
		pvc.c.update_board(choice.to_i, "X")
		board.update_board(choice.to_i, "X")
		pvc.c_arr << choice
		print pvc.c_arr
		print board.board
		board.check_win("X")
		if board.win
			session[:state] = "Player Wins"
			session[:won] = "true"
			redirect '/rand_game'
		end

	
		var1, var2 = pvc.cpu_move(Player.new("Tom", "O"))
		pvc.c.update_board(var1.to_i, var2)
		board.update_board(var1.to_i, var2)
		board.check_win("O")
		if board.win
			session[:state] = "Player Wins"
			session[:won] = "true"
			redirect '/rand_game'
		end
	else
		redirect '/rand_game?invalide move!!!'
	end
	if board.moves_taken >= 9
		session[:state] = "Draw"
		session[:won] = "true"
		redirect '/rand_game'
	end
	redirect '/rand_game'
end

post '/rand_replay' do
	session[:won] = "false"
	session[:state] = "Lets Play"
	session[:board] = Board.new
	session[:pvc] = PlayerComp.new
	redirect '/rand_game'
end

post '/pvp' do

	redirect '/play_game'
end


#========================================

get '/play_game' do
	won = session[:won] || false
	nom = session[:nom] || 0
	session[:board] = session[:board] || Board.new
	session[:pvc] = session[:pvc] || PlayerComp.new
	state = session[:state] || "Lets Play"
	erb :player, locals:{board: session[:board], state: state, nom: nom, won: won}
end

post '/play_game' do
	pvc = session[:pvc]
	board = session[:board]
	choice = params[:choice]
	session[:nom] = params[:nom].to_i
	session[:nom] += 1
	session[:won] = "false"
	board.moves_taken = 0

	p choice


		if pvc.c.available_options(choice.to_i) == true
			if session[:nom] % 2 == 0
				pvc.c.update_board(choice.to_i, "X")
				board.update_board(choice.to_i, "X")
				pvc.c_arr << choice
				print pvc.c_arr
				print board.board
				board.check_win("X")
					if board.win
						session[:state] = "Player1 Won"
						session[:won] = "true"
						redirect '/play_game'
					end
			else
		
				pvc.c.update_board(choice.to_i, "O")
				board.update_board(choice.to_i, "O")
				board.check_win("O")
					if board.win
						session[:state] = "Player2 Won"
						session[:won] = "true"
						redirect '/play_game'
					end
				end
		else
			redirect '/play_game?invalide move!!!'
		end
	if pvc.c.moves_taken >= 9
		session[:state] = "Draw"
		redirect '/play_game'
	end
	redirect '/play_game'
end

post '/play_replay' do
	session[:nom] = 0
	session[:won] = "false"
	session[:board] = Board.new
	session[:pvc] = PlayerComp.new
	session[:state] = "Lets play"
	redirect '/play_game'
end



# ------------------------------------------------------------
# Computer vs computer
post '/comp1' do

	redirect '/h_game'
end

get '/h_game' do
	won = session[:won] || false
	nom = session[:nom] || 0
	session[:board] = session[:board] || Board.new
	session[:cvc] = session[:cvc] || RandomComp.new
	state = session[:state] || "Lets Play"
	erb :h_comp, locals:{board: session[:board], state: state, nom: nom, won: won}
end

post '/h_game' do
	cvc = session[:cvc]
	board = session[:board]
	choice = params[:choice]
	session[:nom] = params[:nom].to_i
	session[:nom] += 1
	session[:won] = "false"
	board.moves_taken = 0
	p choice

		
		var1, var2 = cvc.h_move2(Player.new("Jim", "X"))
		cvc.c.update_board(var1.to_i, var2)
		board.update_board(var1.to_i, var2)
		cvc.c_arr << var1
		print cvc.c_arr
		print board.board
		board.check_win("X")
		if board.win
			session[:state] = "Player Won"
			session[:won] = "true"
			redirect '/h_game'
			
		end

		sleep 2
		var3, var4 = cvc.h_move(Player.new("Tom", "O"))
		cvc.c.update_board(var3.to_i, var4)
		board.update_board(var3.to_i, var4)
		cvc.c_arr2 << var3
		board.check_win("O")
		if board.win
			session[:state] = "Computer Won"
			session[:won] = "true"
			redirect '/h_game'
		end
	
	if cvc.c.moves_taken >= 9
		session[:state] = "Draw"
		session[:won] = "true"
		redirect '/h_game'
	end
	redirect '/h_game'
end

post '/h_replay' do
	session[:nom] = 0
	session[:won] = "false"
	session[:board] = Board.new
	session[:cvc] = RandomComp.new
	session[:state] = "Lets play"
	redirect '/h_game'
end



#===============================================================================
# sequential cvc

post '/comp2' do

	redirect '/s_game'
end

get '/s_game' do
	won = session[:won] || false
	nom = session[:nom] || 0
	session[:board] = session[:board] || Board.new
	session[:cvc] = session[:cvc] || RandomComp.new
	state = session[:state] || "Lets Play"
	erb :s_comp, locals:{board: session[:board], state: state, nom: nom, won: won}
end

post '/s_game' do
	cvc = session[:cvc]
	board = session[:board]
	choice = params[:choice]
	session[:nom] = params[:nom].to_i
	session[:nom] += 1
	session[:won] = "false"
	board.moves_taken = 0
	p choice

	if board.win != true	
		var1, var2 = cvc.s_move(Player.new("Jim", "X"))
		cvc.c.update_board(var1.to_i, var2)
		board.update_board(var1.to_i, var2)
		cvc.c_arr << var1
		print cvc.c_arr
		print board.board
		board.check_win("X")
		if board.win
			session[:state] = "Player Won"
			session[:won] = "true"
			redirect '/s_game'
			
		end

		sleep 1
		var3, var4 = cvc.s_move(Player.new("Tom", "O"))
		cvc.c.update_board(var3.to_i, var4)
		board.update_board(var3.to_i, var4)
		cvc.c_arr2 << var3
		board.check_win("O")
		if board.win
			session[:state] = "Computer Won"
			session[:won] = "true"
			redirect '/s_game'
		end
	
	if cvc.c.moves_taken >= 9
		session[:state] = "Draw"
		session[:won] = "true"
		redirect '/s_game'
	end
	redirect '/s_game'
end
	
end

post '/s_replay' do
	session[:won] = "false"
	session[:nom] = 0
	session[:board] = Board.new
	session[:cvc] = RandomComp.new
	session[:state] = "Lets play"
	redirect '/s_game'
end


#=======================================================
#random cvc

post '/comp3' do

	redirect '/r_game'
end

get '/r_game' do
	won = session[:won] || false
	nom = session[:nom] || 0
	session[:board] = session[:board] || Board.new
	session[:cvc] = session[:cvc] || RandomComp.new
	state = session[:state] || "Lets Play"
	erb :r_comp, locals:{board: session[:board], state: state, nom: nom, won: won}
end

post '/r_game' do
	cvc = session[:cvc]
	board = session[:board]
	choice = params[:choice]
	session[:nom] = params[:nom].to_i
	session[:nom] += 1
	session[:won] = "false"
	board.moves_taken = 0
	p choice

	if board.win != true
		var1, var2 = cvc.random_move(Player.new("Jim", "X"))
		cvc.c.update_board(var1, var2)
		board.update_board(var1, var2)
		cvc.c_arr << var1
		print cvc.c_arr
		print board.board
		board.check_win("X")
		if board.win
			session[:state] = "Player Won"
			session[:won] = "true"
			redirect '/r_game'		
		end

		sleep 1
		var3, var4 = cvc.random_move(Player.new("Tom", "O"))
		cvc.c.update_board(var3, var4)
		board.update_board(var3, var4)
		cvc.c_arr2 << var3
		board.check_win("O")
		if board.win
			session[:state] = "Computer Won"
			session[:won] = "true"
			redirect '/r_game'
		end
	
	if cvc.c.moves_taken >= 9
		session[:state] = "Draw"
		session[:won] = "true"
		redirect '/r_game'
	end
		redirect '/r_game'
end

end

post '/r_replay' do
	session[:nom] = 0
	session[:board] = Board.new
	session[:cvc] = RandomComp.new
	session[:state] = "Lets play"
	session[:won] = "false"
	redirect '/r_game'
end