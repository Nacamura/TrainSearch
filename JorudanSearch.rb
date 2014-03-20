class JorudanSearch

  require 'mechanize'
  Route = Struct.new(:name, :time, :duration, :exchange, :fare)

  def routes(from_st, to_st, route_st, gap_seconds)
    parse_to_routes(get_mechanize_res(from_st, to_st, route_st, gap_seconds))
  end

  def get_mechanize_res(from_st, to_st, route_st, gap_seconds)
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    search_page = agent.get 'http://www.jorudan.co.jp/norikae/'
    form = search_page.forms[0]

    target_time = (Time.now + gap_seconds)
    hour = target_time.hour.to_s
    min = target_time.min.to_s
    min1 = min.slice(0)
    min2 = min.slice(1)

    form.field_with(:name=>'eki1').value = from_st
    form.field_with(:name=>'eki2').value = to_st
    form.field_with(:name=>'eki3').value = route_st
    form.field_with(:name=>'Dhh').value = hour
    form.field_with(:name=>'Dmn1').value = min1
    form.field_with(:name=>'Dmn2').value = min2
    form.click_button
  end

  def parse_to_routes(mechanize_res)
    routes = []
    mechanize_res.search("tr").each do |tr|
      tds = tr.search("td")
      if(tds.count != 6) then break end
      routes << Route.new(tds[0].text, tds[1].text, tds[2].text, tds[3].text, tds[4].text)
    end
    routes
  end

  def route_home
    text = ""
    text += routes("六本木一丁目", "ひばりヶ丘（東京）", "", 300)[0].time
    text += "\n"
    text += routes("六本木一丁目", "ひばりヶ丘（東京）", "小竹向原", 300)[0].time
    text += "\n"
    text += routes("神谷町", "ひばりヶ丘（東京）", "", 300)[0].time
  end

end