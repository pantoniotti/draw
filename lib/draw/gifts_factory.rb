class GiftsFactory

  def self.clear
    gifts = []
    store = DrawFactory.store
    store.transaction do
      store[:gifts] = []
      gifts = store[:gifts]
    end
    true
  end

  def self.get(search = nil)
    begin
      gifts = []
      store = DrawFactory.store
      store.transaction do
        gifts = store[:gifts]
      end
      gifts = search.nil? ? gifts : gifts.select {|g| g.from.downcase.include? search.downcase }
      return gifts
    rescue Exception => e
      puts "GiftsFactory::get \t ERROR:\t #{e.message}"
    end
  end

end