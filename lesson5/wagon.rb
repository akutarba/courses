class Wagon

  attr_reader :type, :wagon_size, :number

  attr_accessor :taken_size


  def initialize(wagon_type, size)
    @type = wagon_type
    @wagon_size = size #количество мест в пасс вагоне или размер грузового
    @number = rand(100)
  end

  def free_space_by_wagon_type
    if self.type == :passenger
      "free #{self.free_seats} seats"
    elsif self.type == :cargo
      "free #{self.free_volume}l "
    end
  end

  def taken_space_by_wagon_type
    if self.type == :passenger
      "taken #{self.taken_seats} seats"
    elsif self.type == :cargo
      "taken #{self.taken_volume}l"
    end
  end
end
