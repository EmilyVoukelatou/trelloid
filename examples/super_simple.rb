require_relative '../lib/trelloid'
API_KEY = '39339899d60b025266c5a344b0044e79'
TOKEN = '13264ed6619a9d4bd157e0af8b5a32b828d1079e77f88133150f924761676e5d'
app = Trelloid.new(API_KEY, TOKEN)
app.behaviour do
  task "Say hello" do
   hello = 3
   process do
     puts 'Hello'
     puts card.name
     puts hello
   end

  end
end

app.run
