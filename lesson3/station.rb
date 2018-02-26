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

#Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  def trains_by_type(type)
    @trains.select {|train| train == type}
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

st = Station.new("Munchen")
st.add_train("gruz")
st.add_train("pass")
st.add_train("pass")

puts st

type = "pass"
st.trains_by_type(type)