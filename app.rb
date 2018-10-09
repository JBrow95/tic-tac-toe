require 'sinatra'
require_relative 'game.rb'
require_relative 'board.rb'
require_relative 'computer_front.rb'
enable :sessions

get '/' do
		
	session[:board] = session[:board] || Board.new
	session[:pvc] = session[:pvc] || PlayerComp.new
	erb :dashboard, locals:{board: session[:board]}
end

post '/game' do
	pvc = session[:pvc]
	board = session[:board]
	choice = params[:choice]
	p choice

		if pvc.c.available_options(choice.to_i) == true
		pvc.c.update_board(choice.to_i, "X")
		board.update_board(choice.to_i, "X")
		pvc.c_arr << choice
		print pvc.c_arr
		print board.board
		board.check_win("X")
		if board.win
			redirect '/?win'
		end

	
		var1, var2 = pvc.s_move(Player.new("Tom", "O"))
		pvc.c.update_board(var1.to_i, var2)
		board.update_board(var1.to_i, var2)
		board.check_win("O")
		if board.win
			redirect '/?compwin'
		end
	else
		redirect '/?a=b'
	end
	if board.moves_taken >= 9
		redirect '/?draw'
	end
	redirect '/'
end