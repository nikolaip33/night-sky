class NightSky::CLI

  def call
    page = NightSky::Scraper.new.get_page
    binding.pry
  end

end #class NightSky::CLI
