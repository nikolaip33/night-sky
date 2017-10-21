class NightSky::Scraper

  attr_reader :year

  def initialize(year="2017")
    @year = year
  end

  def get_page
    Nokogiri::HTML(open("http://www.seasky.org/astronomy/astronomy-calendar-#{self.year}.html"))
  end

  def scrape_events
    get_page.search("#right-column-content li")
  end

  def make_events
    scrape_events.each do |event|
      NightSky::Event.new_from_item(event, self.year)
    end
  end

end #Class NightSky Scraper
