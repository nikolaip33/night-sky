class NightSky::CLI

  def call
    # NightSky::Scraper.new.make_events
    # NightSky::Scraper.new(2018).make_events
    start
  end

  def start
    puts "Welcome to The Night Sky\n"
    puts "What year would you like to search?"
    input = 0
    until input.between?(2017,2030)
      input = gets.strip.to_i
    end
    NightSky::Scraper.new(input).make_events
    list_events_with_index(NightSky::Event.meteor_showers)
    puts "Which event would you like more information for?"
    input = 0
    until input.between?(1,NightSky::Event.meteor_showers.length)
      input = gets.chomp.to_i
    end
    puts NightSky::Event.meteor_showers[input-1].description
  end

  def events_menu
    puts "1. Lunar Calendar"
    puts "2. Meteor Showers"
    puts "3. Planetary Viewing"
    puts "4. Manual Search"
  end

  def list_events_with_index(events)
    events.each.with_index(1) do |e, i|
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
    puts "\nSearch for an Astrononical Event"
    input = gets.chomp
    results = NightSky::Event.select_by(input)
    if results.length == 0
      puts "\nSorry, 0 matches were found."
    else
      puts results.length == 1 ? "\nWe found 1 match:" : "\nWe found #{results.length} matches:"
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
