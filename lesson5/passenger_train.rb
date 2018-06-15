require_relative '../lesson5/train'
require_relative 'validation'
require_relative 'accessors'

class PassengerTrain < Train
  include Validation
  include Accessors

  attr_reader :number

  validate :number, :presence
  validate :number, :type_number, String
  validate :number, :format, NUMBER_TEMPLATE

  def initialize(number)
    super(number, :passenger)
  end
end
