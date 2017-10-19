class NightSky::CLI

  def call
    NightSky::Scraper.new.make_events
    list_events
  end

  def list_events
    NightSky::Event.all.each.with_index(1) do |event, i|
      puts "#{i}. #{event.date} - #{event.name}"
    end
  end

  def show_event(input)

  end

end #class NightSky::CLI
