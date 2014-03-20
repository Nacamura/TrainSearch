load './MyJSON.rb'
load './MyLogger.rb'
load './TwitCommunicator.rb'
load './JorudanSearch.rb'

class TrainSearch
  include MyLogger

  def execute
    settings = MyJSON.load_json("settings.txt")
    twitcom = TwitCommunicator.new(settings)
    tweets = twitcom.gather_new_tweets
    tweets.each do |t|
      lines = []
      if(twitcom.since_id < t.id) then twitcom.since_id = t.id end
      t.text.lines do |l|
        lines << l
      end
      if(lines[0].strip != "connective pi") then next end
      if(lines[1].strip == "home")
        twitcom.route_home
      end
    end
  end

end

t = TrainSearch.new
t.execute
