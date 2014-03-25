load './JorudanSearch.rb'

class TrainSearch
  include MyLogger

  @jorudan

  def route_home(twitcom)
    @jorudan ||= JorudanSearch.new
    text = @jorudan.route_home
    twitcom.create_direct_message(text)
    text
  end

end