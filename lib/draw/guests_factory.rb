class GuestsFactory

  def self.add(new_guests = nil)
    begin
      guests = []
      store = DrawFactory.store
      store.transaction do
        guests = store[:guests] || []
      end
      new_guests.each do |new_guest|
        guest = Guest.new(new_guest[0], new_guest[1])
        add = (guests.length > 0 && guests.select {|g| g.name.downcase.include? guest.name.downcase }.length > 0) ? false : true
        if add
          store.transaction do
            store[:guests] << guest
            if store[:guests].include? guest
              guests << guest
            end
          end
        end
      end
      true
    rescue Exception => e
      puts "GuestsFactory::add \t ERROR:\t #{e.message}"
    end
  end

  def self.clear()
    begin
      guests = []
      store = DrawFactory.store
      store.transaction do
        store[:guests] = []
      end
      true
    rescue Exception => e
      puts "GuestsFactory::add \t ERROR:\t #{e.message}"
    end
  end

  def self.delete(index = nil)
  end

  def self.get(search = nil)
    begin
      guests = []
      store = DrawFactory.store
      store.transaction do
        guests = store[:guests]
      end
      guests = search.nil? ? guests : guests.select {|g| g.name.downcase.include? search.downcase }
      return guests
    rescue Exception => e
      puts "GuestsFactory::get \t ERROR:\t #{e.message}"
    end
  end

  def self.seed
    begin
      guests = []
      line_num = 0
      text = File.open('guests.txt').read
      text.gsub!(/\r\n?/, "\n")
      text.each_line do |line|
        values = line.split(",")
        name = values[0] ? values[0].strip() : nil
        joint = values[1] ? values[1].strip() : nil
        if name && name != ""
          guests << [name, joint]
        end
      end
      return guests
    rescue Exception => e
      puts "GuestsFactory::seed \t ERROR:\t #{e.message}"
    end
  end

end