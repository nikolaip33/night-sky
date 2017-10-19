class NightSky::CLI

  def call
    NightSky::Scraper.new.make_events
    list_lunar_calendar
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

  def show_event(input)

  end

end #class NightSky::CLI
