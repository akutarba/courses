=begin
Класс Station (Станция):
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

=end

require_relative 'instance_counter.rb'
require_relative 'validation'

class Station

  include InstanceCounter
  include Validation

  NAME_TEMPLATE = /^\w+/

  attr_reader :trains, :name
  #заводим инстанс переменную класса куда складываем все станции
  @@stations = []

  def self.all
    @@stations
  end

  #Имеет название, которое указывается при ее создании
  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self # при инициализации добавляем станцию в инстанс переменную класса, таким образом у нас будет там полный список
    register_instance
  end

  def to_s
    @name
  end



  def validate!
    raise 'Station name is nil!' if @name.nil?
    raise 'Wrong format of station name!' if @name !~ NAME_TEMPLATE
    raise 'There is a station with this name already!' if @@stations.detect {|item| item.name == self.name}
    true
  end

  # У класса Station:
  # написать метод, который принимает блок и проходит по всем поездам на станции, передавая каждый поезд в блок.

  def each_train(&block)
    self.trains.each {|train| block.call(train)} if block_given?
  end

  #Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  def trains_by_type(type)
    @trains.select {|train| train.type == type}
  end

  #Может принимать поезда (по одному за раз)
  def add_train(train)
    @trains << train
  end

  # Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).
  def remove_train(train)
    @trains.delete(train)
  end

end
