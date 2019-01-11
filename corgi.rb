require 'sinatra'
require 'dotenv/load'
require 'intercom'
require 'json'

def initialize_intercom
	if @intercom.nil? then
		token = ENV['TOKEN']
		@intercom = Intercom::Client.new(token: ENV['token'])
	end
end

def get_convo
	convo_content = JSON.parse(@intercom.conversations.find(:id => convo_id))
	puts convo_content
end

def is_corgi_convo
	if convo_content["corgi" | "Corgi"]
		puts "convo includes corgi"
	end
end

def send_reply
	@intercom.conversations.reply(:id => convo_id, :type => 'admin', 
								  :message_type => 'comment', 
								  :body => '<html><body><img src="https://gph.is/1cpsZE7"></body></html>')
end

class Corgi < Sinatra::Base
	get '/' do 
		"Hello World"
	end

	post '/' do
		convo_id = JSON.parse(request.body.read)["data"]["item"]["id"]
		puts convo_id
		get_convo(convo_id)
	end
end

