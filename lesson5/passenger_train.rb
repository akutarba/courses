require_relative '../lesson5/train'

class PassengerTrain < Train
  def initialize(number)
    super(number, :passenger)
  end
end
