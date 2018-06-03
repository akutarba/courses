require_relative 'station'
require_relative 'route'
require_relative 'vendor'
require_relative 'instance_counter'
require_relative 'validation'
require_relative 'acessors'

class Train
  include Vendor
  include InstanceCounter
  include Validation

  extend Acessors

  NUMBER_TEMPLATE = /^[a-z\d]{3}-?[a-z\d]{2}$/i

  @@trains = {}

  attr_reader :number, :type, :current_speed, :wagons, :current_station_index
  attr_acessor_with_history :number

  validate :number, :presence
  validate :number, :type_number, String
  validate :number, :format, NUMBER_TEMPLATE

  def self.find(train_number)
    @@trains[train_number]
  end

  def initialize(number, type)
    @number = number
    validate!
    @type = type
    @wagons = []
    @current_speed = 0
    @current_station_index = 0
    @@trains[number] = self
    register_instance
  end

  def to_s
    @number
  end

  # def validate!
  #   raise 'Train number is nil!' if number.nil?
  #   raise 'Wrong format of train number!' if number !~ NUMBER_TEMPLATE
  #   raise "Train #{number} is already exist!" unless @@trains[number].nil?
  #   true
  # end

  #  написать метод, который принимает блок и проходит по всем вагонам поезда
  # (вагоны должны быть во внутреннем массиве), передавая каждый объект вагона в блок.
  def each_wagon
    wagons.each_with_index { |wagon, i| yield wagon, i } if block_given?
  end

  # Может набирать скорость
  def speed_up(speed_delta)
    @current_speed += speed_delta if speed_delta >= 0
  end

  #  Может тормозить (сбрасывать скорость до нуля)
  def brake_train
    @current_speed = 0
  end

  # возвращает true если тип вагона и поезда совпали
  def relevant_wagon?(wagon)
    wagon.type == @type
  end

  # добавляет в массив вагонов, проверяет на соответствие типа вагона и поезда
  def add_wagon(wagon)
    @wagons << wagon if @current_speed.zero? && relevant_wagon?(wagon)
  end

  # удаляет из массива вагонов
  def remove_wagon(wagon)
    return if @current_speed.nonzero?
    @wagons.delete(wagon)
  end

  #  Может принимать маршрут следования (объект класса Route).
  def route=(route)
    @route = route
    @current_station_index = 0
    # при установке маршрута, добавляем поезд на станцию
    @route.stations[@current_station_index].add_train(self)
  end

  # возвращает следующую станцию - объект
  def next_station
    @route.stations[@current_station_index + 1]
  end

  # возвращает предыдущую станцию - объект
  def previous_station
    @route.stations[@current_station_index - 1] if @current_station_index.nonzero?
  end

  def current_station
    @route.stations[@current_station_index]
  end

  # Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад,
  # но только на 1 станцию за раз.

  def run_next_station
    return if next_station.nil? # если следующая станция не последняя идем дальше, если последняя выходим из метода

    # удаляем поезд с текущей станции
    current_station.remove_train(self)

    # сдвигаем индекс вперед
    @current_station_index += 1

    # добавляем поезд на станцию прибытия
    current_station.add_train(self)
  end

  def run_previous_station
    return if get_previous_station.nil?

    # удаляем поезд с текущей станции
    current_station.remove_train(self)

    # индекс влево
    @current_station_index -= 1

    # добавляем поезд на станцию прибытия
    current_station.add_train(self)
  end

  def self.trains
    @@trains
  end
end

# test for acessors
#
# train = Train.new('125-01',:passenger)
# train.number = '126-01'
# train.number = '127-01'
#
# print "Train had numbers: #{train.number_history}"
