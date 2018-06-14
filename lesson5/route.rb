require_relative 'instance_counter'
require_relative 'validation'

class Route
  include InstanceCounter
  include Validation

  attr_reader :stations

  validate :first_station, :presence
  validate :first_station, :type, Station


  validate :last_station, :presence
  validate :last_station, :type, Station


  #  Имеет начальную и конечную станцию, а также список промежуточных станций.
  # Начальная и конечная станции указываютсся при создании маршрута
  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
    valid?
    register_instance
  end

  def to_s
    @stations.join(',')
  end

  #  Может добавлять промежуточную станцию в список
  def add_station(station)
    @stations.insert(-2, station)
  end

  # Может удалять промежуточную станцию из списка
  def remove_station(station)
    @stations.delete(station) if station != @stations.first || station != @stations.last
  end

  # def validate!
  #   raise 'Stations are nil!' if @stations.nil?
  #   @stations.each_with_index do |item, index|
  #     raise "The station ##{index + 1} is not an object!" unless item.instance_of? Station
  #   end
  #   true
  # end
end
