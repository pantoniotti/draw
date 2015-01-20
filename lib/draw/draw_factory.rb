require 'pstore'

class DrawFactory

  attr_accessor :guests, :gifts, :store

  def initialize
    @store = store
    @guests = get_guests
    @gifts = get_gifts
  end

  # Add one or several guests in the draw
  def add(guests = [])
    begin
      guests.each do |new_guest|
        guest = Guest.new(new_guest[0], new_guest[1])
        add = (@guests.length > 0 && @guests.select {|g| g.name.downcase.include? guest.name.downcase }.length > 0) ? false : true
        if add
          @guests << guest unless @guests.include? guest
          @store.transaction do
            @store[:guests] = @guests
          end
        end
      end
      true
    rescue Exception => e
      puts "DrawFactory::add \t ERROR:\t #{e.message}"
      false
    end
  end

  # Clear all guests and gifts from the draw
  def clear
    begin
      @guests = []
      @gifts = []
      @store.transaction do
        @store[:guests] = []
        @store[:gifts] = []
      end
      true
    rescue Exception => e
      puts "DrawFactory::clear \t ERROR:\t #{e.message}"
    end
  end

  def get(search = nil)
    begin
      guests = []
      guests = search.nil? ? @guests : @guests.select {|g| g.name.downcase.include? search.downcase }
      return guests
    rescue Exception => e
      puts "DrawFactory::get \t ERROR:\t #{e.message}"
    end
  end

  def match
    new_guests = []
    @guests.each do |guest|
      new_guests << [guest.joint, guest.name] unless guest.joint.nil?
    end
    return add(new_guests)
  end

  # Removes a guest from the draw
  def remove(guest = nil)

  end

  # Clear all guests and gifts from the draw
  def reset
    begin
      @gifts = []
      @store.transaction do
        @store[:gifts] = []
      end
      true
    rescue Exception => e
      puts "DrawFactory::reset \t ERROR:\t #{e.message}"
    end
  end

  def run
    begin
      if @guests
        recipients = @guests.map { |g| g.name }
        @guests.each do |guest|
          recipient = guest.name
          while recipients.count > 0 && (guest.name == recipient || guest.joint == recipient)
            recipient = recipients.shuffle.sample
          end
          from = guest.joint.nil? ? guest.name : "#{guest.name}" + " / (#{guest.joint})"
          gift = Gift.new(from, recipient)
          @gifts << gift
          # Remove recipient from recipients array
          recipients.reject! {|x| x == recipient }
        end
        @store.transaction do
          @store[:gifts] = @gifts
        end
      end
      true
    rescue Exception => e
      puts "DrawFactory::run \t ERROR:\t #{e.message}"
    end
  end

  def seed
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
      puts "DrawFactory::seed \t ERROR:\t #{e.message}"
    end
  end

  def show(guest  = nil)
    begin
      gifts = []
      gifts = search.nil? ? @gifts : @gifts.select {|g| g.from.downcase.include? search.downcase }
      return gifts
    rescue Exception => e
      puts "GiftsFactory::get \t ERROR:\t #{e.message}"
    end
  end

  private

  def get_gifts
    gifts = []
    store.transaction do
      gifts = store[:gifts] || []
    end
    gifts
  end

  def get_guests
    guests = []
    store.transaction do
      guests = store[:guests] || []
    end
    guests
  end

  def store
    file = %(#{ENV['HOME']}/draw.pstore)
    @store || PStore.new(file)
  end

end