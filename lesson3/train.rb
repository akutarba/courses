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
  def speed_up(speed_delta)
    if speed_delta >= 0
      @current_speed += speed_delta
    end
  end

#  Может тормозить (сбрасывать скорость до нуля)
  def brake_train
    @current_speed = 0
  end


#Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов).
  def attach_wagon
    if @current_speed == 0
      @wagons += 1
    end
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
  def route(route)
    @route = route
    @current_station = @route.stations[0]
  end

  def current_station_index
    @route.stations.index(@current_station)
  end

# Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад,
# но только на 1 станцию за раз.

  def last_index
    @route.stations.length - 1
  end


  def run_next_station
    index = current_station_index
    last = last_index
    if index != last
      index += 1
      # здесь я хочу проверить, что станция не была предпоследней, потому что иначе нет следующей, а только меняется текущая и предпоследняя
      if index != last
        @next_station = @route.stations[index + 1] # сдвигаю следующую за текущей
        @previous_station = @current_station # делаю предыдущую текущей
        @current_station = @route.stations[index] # сдвигаю текущую на один
      else
        @previous_station = @current_station # делаю предыдущую текущей
        @current_station = @route.stations[index] # сдвигаю текущую на один и она становится последней
      end
    else
      print "You have arrived to the last station of the route! "
    end
  end

  def run_previous_station
    index = current_station_index
    if !(index.zero?) # index не ноль, то не первый элемент массива
      index -= 1

      # здесь я хочу проверить, что станция не была второй, потому что иначе нет предыдущей, а только меняется текущая и след за ней
      if !(index.zero?) # index не ноль, то есть снова не первый элемент массива. получилось дважды одно и то же, но не знаю как лучше сделать
        @previous_station = @route.stations[index - 1]
        @current_station = @route.stations[index]
        @next_station = @current_station
      else
        @current_station = @route.stations[index]
        @next_station = @current_station
      end
    else
      print "You are  on the first station of the route! "
    end
  end

end

train = Train.new('123', 'pass', 23)

puts "Train number #{ train.number } "

train.speed_up(90)
puts "Current speed_delta: #{ train.current_speed } "

train.attach_wagon
puts "Number of wagons #{ train.wagons } "

route = Route.new("A", "B")
train.route(route)
route.add_station(station: "C")
route.add_station(station: "D")

puts "Current route #{ route.stations }"
puts "Current station #{ train.current_station }"

(route.stations.length).times do
  train.run_next_station
  puts "Current station #{ train.current_station }"
end

(route.stations.length).times do
  train.run_previous_station
  puts "Current station #{ train.current_station }"
end
