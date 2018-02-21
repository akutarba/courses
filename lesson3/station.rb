=begin
Класс Station (Станция):
Имеет название, которое указывается при ее создании
Может принимать поезда (по одному за раз)
Может возвращать список всех поездов на станции, находящиеся в текущий момент
Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

=end

class Station

  attr_reader :trains

#Имеет название, которое указывается при ее создании
  def initialize(name)
    @name = name
    @trains = []
  end

#Может принимать поезда (по одному за раз)
  def add_train(train)
    @trains << train
  end

#Может возвращать список всех поездов на станции, находящиеся в текущий момент
  def get_trains
     puts "Trains on the station #{@name}: #{@trains} "
  end

#Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  def get_trains_by_type(type)
    puts "#{@trains.select {|train| train == type}.length} #{type} trains"
  end

  def remove_train(train)
    @trains.delete(train)
  end

end

st = Station.new("Munchen")
st.add_train("gruz")
st.add_train("pass")
st.add_train("pass")

st.get_trains

type = "pass"
st.get_trains_by_type(type)