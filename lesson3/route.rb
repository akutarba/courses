=begin
класс Route (Маршрут):
    Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута,
а промежуточные могут добавляться между ними.
        Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной
=end


class Route
  attr_reader :stations_list

  #  Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута
  def initialize(first_station, last_station)
    @stations_list = [first_station, last_station]
  end

#  Может добавлять промежуточную станцию в список
  def add_station(station)
    @stations_list.insert(-2, station)
  end

#Может удалять промежуточную станцию из списка
  def remove_station(station)
    @stations_list.delete(station)
  end

#Может выводить список всех станций по-порядку от начальной до конечной
  def station_list
    puts @stations_list
  end
end

route = Route.new("A", "B")

puts route.stations_list

