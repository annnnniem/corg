require 'sinatra'
require 'dotenv/load'
require 'intercom'
require 'json'

get '/' do 
	"hi"
end

post '/' do 
	response = JSON.parse(request.body.read)
	conversation_text = response["data"]["item"]["conversation_message"]["body"]
	puts conversation_text
	if conversation_text.include? "corgi"
		puts "Convo contains corgi"
		initialize_intercom
		convo_id = response["data"]["item"]["id"]
		@intercom.conversations.reply(:id => convo_id, :type => 'admin', :admin_id => '1283891',
								  :message_type => 'comment', 
								  :body => '<html><body><img src="https://i.giphy.com/media/KLbq09EoE1uDu/giphy.webp"></body></html>')

	end
end

def initialize_intercom
	if @intercom.nil? then
		token = ENV['TOKEN']
		@intercom = Intercom::Client.new(token: 'dG9rOmI3NTFjMjE1X2NhMThfNGEwOF9iNGEwXzgzZDMzMTQ3YTU0YzoxOjA=')
	end
end

#ask joel: moving this into methods -- how do I set up my variables?