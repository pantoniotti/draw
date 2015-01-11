class Gift

  attr_accessor :from, :to

  def initialize(from = nil, to = nil)
    @from = from
    @to = to
  end

end
