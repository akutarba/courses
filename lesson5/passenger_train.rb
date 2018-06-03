require_relative '../lesson5/train'
require_relative 'validation'
require_relative 'acessors'

class PassengerTrain < Train
  include Validation
  include Acessors

  attr_reader :number

  validate :number, :presence
  validate :number, :type_number, String
  validate :number, :format, NUMBER_TEMPLATE

  def initialize(number)
    super(number, :passenger)
  end
end
