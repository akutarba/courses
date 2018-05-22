=begin
Для пассажирских вагонов:
Добавить атрибут общего кол-ва мест (задается при создании вагона)
Добавить метод, который "занимает места" в вагоне (по одному за раз)
Добавить метод, который возвращает кол-во занятых мест в вагоне
Добавить метод, возвращающий кол-во свободных мест в вагоне.
=end

require_relative 'wagon'

class PassengerWagon < Wagon

  attr_accessor :taken_seats, :free_seats
  attr_reader :seats

  def initialize(seats = 30)
    super(:passenger, seats)
    @seats = seats
    @taken_seats = 0
  end

  def take_seat
    self.taken_seats += 1 if self.taken_seats <= @seats
  end

  def free_seats
    self.seats - self.taken_seats
  end
end