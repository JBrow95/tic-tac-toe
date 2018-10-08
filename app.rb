require 'sinatra'
require_relative 'game.rb'
require_relative 'board.rb'
enable :sessions

get '/' do
		
	session[:board] = Board.new
	erb :dashboard, locals:{board: session[:board]}
end

post '/game' do


	redirect '/'
end