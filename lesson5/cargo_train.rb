require_relative '../lesson5/train'

class CargoTrain < Train
  def initialize(number)
    super(number, :cargo)
  end
end
