=begin
Для грузовых вагонов:
Добавить атрибут общего объема (задается при создании вагона)
Добавить метод, которые "занимает объем" в вагоне (объем указывается в качестве параметра метода)
Добавить метод, который возвращает занятый объем
Добавить метод, который возвращает оставшийся (доступный) объем

=end

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
    self.volume - self.taken_volume
  end

  def free_space
    "free #{self.free_volume} l "
  end

  def taken_space
    "taken #{self.taken_volume}l"
  end
end