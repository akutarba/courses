require_relative 'train'

class PassengerTrain < Train
  def initialize(number)
    wagons = 0
    type = "passenger"
    super(number,type , wagons)
  end
end

# a = PassengerTrain.new(4)
# #
# # puts a.type
