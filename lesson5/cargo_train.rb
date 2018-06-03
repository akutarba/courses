require_relative '../lesson5/train'
require_relative 'validation'

class CargoTrain < Train
  include Validation

  attr_reader :number

  validate :number, :presence
  validate :number, :type_number, String
  validate :number, :format, NUMBER_TEMPLATE

  def initialize(number)
    super(number, :cargo)
  end
end
