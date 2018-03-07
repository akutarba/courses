=begin

Класс Train (Поезд):
Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
Может набирать скорость
Может возвращать текущую скорость
Может тормозить (сбрасывать скорость до нуля)
Может возвращать количество вагонов

Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
Может принимать маршрут следования (объект класса Route).
При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад,
но только на 1 станцию за раз.
Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
=end

require_relative 'station'
require_relative 'route'

class Train

# может возвращать номер поезда, его тип, текущую скорость, количество вагонов,
# текущую станцию, следующую и предыдущую станции

  attr_reader :number, :type, :current_speed, :wagons, :current_station_index

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @current_speed = 0
  end

# Может набирать скорость
  def speed_up(speed_delta)
    @current_speed += speed_delta if speed_delta >= 0
  end

#  Может тормозить (сбрасывать скорость до нуля)
  def brake_train
    @current_speed = 0
  end

#Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
  def attach_wagon
    @wagons += 1 if @current_speed == 0
  end

# Может отцеплять вагоны
  def detach_waggon
    return if @wagons.zero? || @current_speed.nonzero?
    @waggons -= 1
  end

#  Может принимать маршрут следования (объект класса Route).
  def route=(route)
    @route = route
    @current_station_index = 0
  end


# возвращает следующую станцию - объект
  def next_station
    @route.stations[@current_station_index + 1]
  end

# возвращает предыдущую станцию - объект
  def get_previous_station
    if @current_station_index.nonzero?
      @route.stations[@current_station_index - 1]
    end
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
end


train = Train.new('123', 'pass', 23)

puts "Train number #{ train.number } "

train.speed_up(90)
puts "Current speed: #{ train.current_speed } "

train.attach_wagon
puts "Number of wagons #{ train.wagons } "

st_first = Station.new("A")
st_last = Station.new("B")

route = Route.new(st_first, st_last)

train.route = route
route.add_station(Station.new("C"))
route.add_station(Station.new("D"))

puts "Current route #{ route.stations }"
puts "Current station #{ train.current_station }"

train.run_next_station

train.run_previous_station
