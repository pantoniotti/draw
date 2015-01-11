class Guest

  attr_accessor :name, :joint, :recipient

  def initialize(name = nil, joint = nil, recipient = nil)
    @name = name
    @joint = joint
    @recipient = recipient
  end

end