require 'json'
load './MyLogger.rb'
load './TwitCommunicator.rb'
load './JorudanSearch.rb'

class TrainSearch
  include MyLogger
  attr_accessor :routes

  def execute
    settings = load_json("settings.txt")
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

  def load_json(textfile_path)
    open(textfile_path) do |io|
      JSON.load(io)
    end
  end

  def store_json(array, textfile_path)
    open(textfile_path, "w") do |io|
      JSON.dump(array, io)
    end
  end

end

t = TrainSearch.new
t.execute
