require_relative 'wagon'
class CargoWagon < Wagon

  def initialize(train_number)
    super(train_number, 'cargo')
  end
end