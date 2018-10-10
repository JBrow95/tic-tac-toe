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
	
	erb :seq_game, locals:{board: session[:board], state: ""}
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
	b = session[:board]
	pvc = session[:pvc]
	pvc.c.reset_board
	b.reset_board
	pvc.c_arr.clear

	redirect '/seq_game'
end

get '/game' do
		
	session[:board] = session[:board] || Board.new
	session[:pvc] = session[:pvc] || PlayerComp.new
	
	erb :game, locals:{board: session[:board], state: ""}
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
		pvc.c.check_win("X")
		if board.win
			redirect '/game?playerwins'
			
		end

	
		var1, var2 = pvc.h_move(Player.new("Tom", "O"))
		pvc.c.update_board(var1.to_i, var2)
		board.update_board(var1.to_i, var2)
		pvc.c.check_win("O")
		if board.win
			redirect '/game?ComputerWins'
		end
	else
		redirect '/game?invalide move!!!'
	end
	if board.moves_taken >= 9
		redirect '/?draw'
	end
	redirect '/game'
end

post '/replay' do
	b = session[:board]
	pvc = session[:pvc]
	pvc.c.reset_board
	b.reset_board
	pvc.c_arr.clear

	redirect '/game'
end