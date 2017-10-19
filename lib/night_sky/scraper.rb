class NightSky::Scraper

  def get_page
    Nokogiri::HTML(open("http://www.seasky.org/astronomy/astronomy-calendar-2017.html"))
  end

  def scrape_events
    get_page.search("#right-column-content li")
  end

  def make_events
    scrape_events.each do |event|
      NightSky::Event.new_from_item(event)
    end
  end

end #Class NightSky Scraper
