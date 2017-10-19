class NightSky::CLI

  def call
    NightSky::Scraper.new.make_events
    search_events
  end

  def list_events
    NightSky::Event.all.each.with_index(1) do |e, i|
      puts " #{i}. #{e.date} - #{e.name}" if i < 10
      puts "#{i}. #{e.date} - #{e.name}" if i >= 10
    end
  end

  def list_lunar_calendar
    NightSky::Event.lunar_calendar.each do |e|
      puts "#{e.date} - #{e.name}"
    end
  end

  def search_events
    puts "Search for an Astrononical Event"
    input = gets.chomp
    results = NightSky::Event.select_by(input)
    if results.length == 0
      puts "Sorry, 0 results were found."
    else
      list_events(results)
    end
    search_events
  end

  def list_events(events)
    events.each do |e|
      puts "#{e.date} - #{e.name}"
    end
  end

  def show_event(input)

  end

end #class NightSky::CLI
