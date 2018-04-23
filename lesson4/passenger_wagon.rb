require_relative 'wagon'

class PassengerWagon < Wagon

  def initialize(train_number)
    super(train_number, 'passenger')
  end
end