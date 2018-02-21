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

require_relative 'route.rb'

class Train

# может возвращать номер поезда, его тип, текущую скорость, количество вагонов,
# текущую станцию, следующую и предыдущую станции

  attr_reader :number, :type, :current_speed, :wagons, :current_station, :next_station, :previous_station

  def initialize(number, type, wagons)
    @number = number
    @type = type
    @wagons = wagons
    @current_speed = 0
  end

# Может набирать скорость
  def speed_up=(speed)
    @current_speed += speed
  end

#  Может тормозить (сбрасывать скорость до нуля)
  def brake_train
    @current_speed = 0
  end


#Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
  def attach_wagon
    if @current_speed == 0
      @wagons += 1
    else
      "You cannot add a wagon while train is moving!"
    end
  end

# Может отцеплять вагоны
  def detach_waggon
    if @wagons == 0
      puts "You cannot detach a wagon, the train is empty!"
    elsif @current_speed == 0
      @waggons -= 1
    else
      "You cannot detach a wagon while train is moving!"
    end
  end

#  Может принимать маршрут следования (объект класса Route).
  def route=(route)
    @route = route
    @current_station = @route.stations_list[0]
    @next_station = @route.stations_list[1]
    @previous_station = nil
  end

# Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад,
# но только на 1 станцию за раз.

  def run_next_station
   if @current_station == @route.stations_list.last
     puts "End of route!"
   end
    station_index = @route.stations_list.index(@current_station) + 1
    @next_station = @route.stations_list[station_index + 1]
    @previous_station = @current_station
    @current_station = @route.stations_list[station_index]
  end

  def run_previous_station
    if @current_station == @route.stations_list.first
      puts "Start of route"
    end
    station_index = @route.stations_list.index(@current_station) - 1
    @next_station = @current_station
    @next_station = @route.stations_list[station_index - 1]
    @current_station = @route.stations_list[station_index]
  end
end


train = Train.new('123', 'pass', 23)

puts train.number
train.speed_up=(90)
puts "Current speed: #{ train.current_speed } "

route = Route.new("A", "B")

train.route=(route)

puts "Current station #{ train.current_station } "