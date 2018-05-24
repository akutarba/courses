class Wagon

  attr_reader :type, :wagon_size, :number

  attr_accessor :taken_size


  def initialize(wagon_type, size)
    @type = wagon_type
    @wagon_size = size #количество мест в пасс вагоне или размер грузового
    @number = rand(100)
  end


end
