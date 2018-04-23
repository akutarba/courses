class Wagon
  attr_reader  :number, :type

  def initialize(train_number, wagon_type)
    @number = train_number
    @type = wagon_type
  end
end
