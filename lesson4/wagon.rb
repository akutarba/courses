class Wagon
  attr_reader  :type

  def initialize(wagon_type)
    @type = wagon_type
  end
  def to_s
    @type
  end
end
