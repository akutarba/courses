require_relative 'wagon'

class CargoWagon < Wagon
  attr_accessor :taken_volume, :free_volume, :volume

  def initialize(volume = 500)
    super(:cargo, volume)
    @volume = volume
    @taken_volume = 0
  end

  def take_volume(val)
    @taken_volume += val if (@taken_volume + val) <= @volume
  end

  def free_volume
    volume - taken_volume
  end

  def free_space
    "free #{free_volume} l "
  end

  def taken_space
    "taken #{taken_volume}l"
  end
end