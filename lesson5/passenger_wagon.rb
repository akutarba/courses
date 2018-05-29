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
    self.taken_seats += 1 if self.taken_seats < @seats
  end

  def free_seats
    self.seats - self.taken_seats
  end

  def free_space
    "free #{free_seats} seats"
  end

  def taken_space
    "taken #{taken_seats} seats"
  end
end