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
require_relative 'route.rb'

class Train

# может возвращать номер поезда, его тип, текущую скорость, количество вагонов,
# текущую станцию, следующую и предыдущую станции

  attr_reader :number, :type, :current_speed, :wagons, :current_station

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
    if @wagons == 0
      puts "You cannot detach a wagon, the train is empty!"
    elsif @current_speed == 0
      @waggons -= 1
    end
  end

#  Может принимать маршрут следования (объект класса Route).
  def route=(route)
    @route = route
    @current_station = @route.stations[0]
  end

# индекс текущей станции в маршруте
  def current_station_index
    @route.stations.index(@current_station)
  end

# возвращает следующую станцию - объект
  def get_next_station
    index = current_station_index
    if index < @route.stations.length
      @route.stations[index + 1]
    else
      nil
    end
  end

# возвращает предыдущую станцию - объект
  def get_previous_station
    index = current_station_index
    if index > 0
      @route.stations[index - 1]
    else
      nil
    end
  end

# Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад,
# но только на 1 станцию за раз.


  def run_next_station
    # вычисляем следующую станцию
    next_station = get_next_station

    if next_station != nil # если она не последняя идем дальше
      # Запоминаем текущую станцию
      old_current_station = @current_station

      # переставляем текущую станцию на следующую
      @current_station = next_station

      # удаляем поезд со прошлой текущей станции
      old_current_station.remove_train(self)

      # добавляем поезд на следующую станцию
      next_station.add_train(self)
    else
      print "You are on the last station of the route! "
    end
  end

  def run_previous_station
    # вычисляем предыдущую станцию
    previous_station = get_previous_station

    if previous_station != nil # если станция не первая

      # Запоминаем текущую станцию
      old_current_station = @current_station

      # переставляем текущую станцию на предыдущую
      @current_station = previous_station

      # удаляем поезд со прошлой текущей станции
      old_current_station.remove_train(self)

      # добавляем поезд на предыдущую станцию
      previous_station.add_train(self)
    else
      print "You are  on the first station of the route! "
    end
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

# (route.stations.length).times do
#   train.run_next_station
#   puts "Current station #{ train.current_station}"
# end
#
# (route.stations.length).times do
#   train.run_previous_station
#   puts "Current station #{ train.current_station }"
# end
