class NightSky::Scraper

  def get_page
    Nokogiri::HTML(open("http://www.seasky.org/astronomy/astronomy-calendar-2017.html"))
  end

end #Class NightSky Scraper
