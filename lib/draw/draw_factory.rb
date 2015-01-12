require 'pstore'

class DrawFactory

  def self.run
    begin
      guests = GuestsFactory.get()
      gifts = GiftsFactory.get()
      if guests
        recipients = guests.map { |g| g.name }
        guests.each do |guest|
          recipient = guest.name
          while recipients.count > 0 && (guest.name == recipient || guest.joint == recipient)
            recipient = recipients.shuffle.sample
          end
          from = guest.joint.nil? ? guest.name : "#{guest.name}" + " / (#{guest.joint})"
          gift = Gift.new(from, recipient)
          gifts << gift
          # Remove recipient from recipients array
          recipients.reject! {|x| x == recipient }
        end
        store = self.store
        store.transaction do
          store[:gifts] = gifts
        end
      end
      true
    rescue Exception => e
      puts "DrawFactory::run \t ERROR:\t #{e.message}"
    end
  end

  def self.store
    PStore.new(%(#{ENV['HOME']}/draw.pstore))
  end

end