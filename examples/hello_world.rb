require_relative '../lib/trelloid'
API_KEY = 'Your trello app key'
TOKEN = 'Your trello bot user token'

app = Trelloid::Bot.new(API_KEY, TOKEN, interval: 5)

app.behaviour do

  task "Say hello world" do
   process do
     puts 'Hello World!'
     puts card.name
   end

  end
end

app.run
