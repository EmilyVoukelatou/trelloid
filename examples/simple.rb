require 'trelloid'

bot = Trelloid.new(token: '' , key: '')
bot.behaviour do

  task 'Send sms' do
    synonyms 'Steile sms'
    set :ignore_case , true

    optionset :reciepients do
      option :all
      option :none
    end

    process do
      option[:reciepients]
      card.desc
      card.votes
      card.members
    end

  end
end
