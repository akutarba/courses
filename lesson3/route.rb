=begin
класс Route (Маршрут):
    Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута,
а промежуточные могут добавляться между ними.
        Может добавлять промежуточную станцию в список
Может удалять промежуточную станцию из списка
Может выводить список всех станций по-порядку от начальной до конечной
=end


class Route
  attr_reader :stations

  #  Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута
  def initialize(first_station, last_station)
    @stations = [first_station, last_station]
  end

  #  Может добавлять промежуточную станцию в список
  def add_station(station:)
    @stations.insert(-2, station)
  end

  #Может удалять промежуточную станцию из списка
  def remove_station(station)
    if station == @stations.first || station == @stations.last
      puts 'Impossible to delete start or end of route station!'
    else
      @stations.delete(station)
    end
  end
end


