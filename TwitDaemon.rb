load './MyJSON.rb'
load './MyLogger.rb'
load './TwitCommunicator.rb'
load './TrainSearch.rb'

class TwitDaemon
  include MyLogger

  @twitcom
  @trainsearch

  def execute
    @twitcom ||= TwitCommunicator.new( MyJSON.load_json("settings.txt") )
    dms = @twitcom.gather_new_direct_messages
    dms.each do |dm|
      lines = []
      dm.text.lines do |l|
        lines << l
      end
      if(lines[0].strip != "connective pi")
        next
      else
        parse_command(lines)
      end
    end
  end

  def parse_command(lines)
    lines.each do |l|
      case l
      when "home"
        @trainsearch ||= TrainSearch.new
        @trainsearch.route_home(@twitcom)
      end
    end
  end

end

TwitDaemon.new.execute