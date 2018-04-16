require_relative 'train'

class CargoTrain < Train
  def initialize(number)
    wagons = 0
    type = "cargo"
    super(number, type, wagons)
  end
end

# a = CargoTrain.new(4)
#
# puts a.type