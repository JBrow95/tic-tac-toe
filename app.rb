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
		
	session[:board] = session[:board] || Board.new
	session[:pvc] = session[:pvc] || PlayerComp.new
	
	erb :seq_game, locals:{board: session[:board]}
end

post '/seq_game' do
	pvc = session[:pvc]
	board = session[:board]
	choice = params[:choice]
	board.moves_taken = 0
	p choice

		if pvc.c.available_options(choice.to_i) == true
		pvc.c.update_board(choice.to_i, "X")
		board.update_board(choice.to_i, "X")
		pvc.c_arr << choice
		print pvc.c_arr
		print board.board
		pvc.c.check_win("X")
		if board.win
			redirect '/seq_game?playerwins'
			
		end

	
		var1, var2 = pvc.s_move(Player.new("Tom", "O"))
		pvc.c.update_board(var1.to_i, var2)
		board.update_board(var1.to_i, var2)
		pvc.c.check_win("O")
		if board.win
			redirect '/seq_game?ComputerWins'
		end
	else
		redirect '/seq_game?invalide move!!!'
	end
	if board.moves_taken >= 9
		redirect '/?draw'
	end
	redirect '/seq_game'
end

post '/seq_replay' do
	session[:board] = Board.new
	session[:pvc] = PlayerComp.new
	redirect '/seq_game'
end

get '/game' do
		
	session[:board] = session[:board] || Board.new
	session[:pvc] = session[:pvc] || PlayerComp.new
	state = session[:state] || "Lets Play"
	erb :game, locals:{board: session[:board], state: state}
end

post '/game' do
	pvc = session[:pvc]
	board = session[:board]
	choice = params[:choice]
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
			redirect '/game'
			
		end

	
		var1, var2 = pvc.h_move(Player.new("Tom", "O"))
		pvc.c.update_board(var1.to_i, var2)
		board.update_board(var1.to_i, var2)
		board.check_win("O")
		if board.win
			session[:state] = "Computer Won"
			redirect '/game'
		end
	else
		redirect '/game?invalide move!!!'
	end
	if pvc.c.moves_taken >= 9
		session[:state] = "Draw"
		redirect '/game'
	end
	redirect '/game'
end

post '/replay' do
	
	session[:board] = Board.new
	session[:pvc] = PlayerComp.new
	session[:state] = "Lets play"
	redirect '/game'
end


#===============Random============================
post '/rand' do

	redirect '/rand_game'
end

get '/rand_game' do
		
	session[:board] = session[:board] || Board.new
	session[:pvc] = session[:pvc] || PlayerComp.new
	
	erb :random, locals:{board: session[:board]}
end

post '/rand_game' do
	pvc = session[:pvc]
	board = session[:board]
	choice = params[:choice]
	board.moves_taken = 0
	p choice

		if pvc.c.available_options(choice.to_i) == true
		pvc.c.update_board(choice.to_i, "X")
		board.update_board(choice.to_i, "X")
		pvc.c_arr << choice
		print pvc.c_arr
		print board.board
		board.c.check_win("X")
		if board.win
			redirect '/rand_game?playerwins'
			
		end

	
		var1, var2 = pvc.cpu_move(Player.new("Tom", "O"))
		pvc.c.update_board(var1.to_i, var2)
		board.update_board(var1.to_i, var2)
		board.c.check_win("O")
		if board.win
			redirect '/rand_game?ComputerWins'
		end
	else
		redirect '/rand_game?invalide move!!!'
	end
	if board.moves_taken >= 9
		redirect '/?draw'
	end
	redirect '/rand_game'
end

post '/rand_replay' do
	session[:board] = Board.new
	session[:pvc] = PlayerComp.new
	redirect '/rand_game'
end

post '/pvp' do

	redirect '/play_game'
end

get '/play_game' do
		
	session[:board] = session[:board] || Board.new
	session[:pvc] = session[:pvc] || PlayerComp.new
	state = session[:state] || "Lets Play"
	erb :player, locals:{board: session[:board], state: state}
end

post '/play_game' do
	pvc = session[:pvc]
	board = session[:board]
	choice = params[:choice]
	board.moves_taken = 0
	p choice


		if pvc.c.available_options(choice.to_i) == true
			until choice != nil
		pvc.c.update_board(choice.to_i, "X")
		board.update_board(choice.to_i, "X")
		pvc.c_arr << choice
		print pvc.c_arr
		print board.board
			end
		board.check_win("X")
		if board.win
			session[:state] = "Player1 Won"
			redirect '/play_game'
			
		end
	
		
		pvc.c.update_board(choice.to_i, "O")
		board.update_board(choice.to_i, "O")
		board.check_win("O")
		if board.win
			session[:state] = "Player2 Won"
			redirect '/play_game'
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
	
	session[:board] = Board.new
	session[:pvc] = PlayerComp.new
	session[:state] = "Lets play"
	redirect '/play_game'
end



# ------------------------------------------------------------
# Computer vs computer
post '/h_comp' do

	redirect '/h_game'
end

get '/h_game' do
		
	session[:board] = session[:board] || Board.new
	session[:pvc] = session[:pvc] || PlayerComp.new
	state = session[:state] || "Lets Play"
	erb :game, locals:{board: session[:board], state: state}
end

post '/h_game' do
	pvc = session[:pvc]
	board = session[:board]
	choice = params[:choice]
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
			redirect '/h_game'
			
		end

	
		var1, var2 = pvc.h_move(Player.new("Tom", "O"))
		pvc.c.update_board(var1.to_i, var2)
		board.update_board(var1.to_i, var2)
		board.check_win("O")
		if board.win
			session[:state] = "Computer Won"
			redirect '/h_game'
		end
	else
		redirect '/game?invalide move!!!'
	end
	if pvc.c.moves_taken >= 9
		session[:state] = "Draw"
		redirect '/h_game'
	end
	redirect '/h_game'
end

post '/h_replay' do
	
	session[:board] = Board.new
	session[:pvc] = PlayerComp.new
	session[:state] = "Lets play"
	redirect '/h_game'
end