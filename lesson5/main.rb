=begin
Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
     1- Создавать станции
     2- Создавать поезда
     3- Добавлять вагоны к поезду
     4- Отцеплять вагоны от поезда

     5- Перемещать поезд по маршруту вперед и назад
     6- Просматривать список станций
     7 и список поездов на станции

     8 Создавать маршруты и управлять станциями в нем (добавлять, удалять)
     9 Назначать маршрут поезду
=end

require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'

class Main

  def select_actions
    puts("Select action:
    1. Create station
    2. Create train
    3. Attach wagons to train
    4. Detach wagons from train
    5. Move train to station
    6. List of stations
    7. List trains on selected station
    8. Create route
    9. Set route to the train
 ")
    gets.chomp
  end

  def run_action(action)
    case action.to_i
    when 1
      create_station
    when 2
      create_train
    when 3
      attach_wagon_to_train
    when 4
      detach_wagon_from_train
    when 5
      move_train_to_station
    when 6
      list_all_stations
    when 7
      list_trains_on_station
    when 8
      create_route
    when 9
      set_route
    else
      select_actions
    end
  end

  # private

  attr_accessor :stations, :trains

  def initialize
    @stations = []
    @trains = []
  end

  def create_station
    puts("Provide station name: ")
    name = gets.chomp
    stations << Station.new(name)
    puts "Station #{name} was created"
  end

  # создает поезд
  def create_train
    puts("Provide train number: ")
    num = gets.chomp
    puts("Provide train type: ")
    type = gets.chomp.to_s

    case type
    when 'passenger'
      trains << PassengerTrain.new(num)
    when 'cargo'
      trains << CargoTrain.new(num)
    else
      puts "Can't create train. Please provide type(cargo|passenger): "
      return
    end
    puts "#{type.capitalize} train with number:#{num} is created. "
  end

  #возвращает поезд по выбранному порядковому номеру из списка всех существующих сейчас
  def select_train
    puts "Select train by number in the list: #{list_all_trains}"
    user_selection = gets.chomp.to_i
    trains[user_selection - 1]
  end

  def attach_wagon_to_train
    current_train = select_train

    if current_train.type == 'cargo'
      current_train.attach_wagon(CargoWagon.new)
    elsif current_train.type == 'passenger'
      current_train.attach_wagon(PassengerWagon.new)
    end
  end

  #все поезда
  def list_all_trains
    trains.each_with_index {|train, i| puts "#{i + 1}) #{train.number}"}
  end

  #возвращает станцию по выбранному порядковому номеру из списка всех существующих станций
  def select_station
    puts "Select station by number in the list: #{list_all_stations}"
    user_selection = gets.chomp.to_i
    stations[user_selection - 1]
  end

  # все станции
  def list_all_stations
    stations.each_with_index {|station, i| puts "#{i + 1}) #{station.name}\n"}
  end

  def detach_wagon_from_train
  end

  def move_train_to_station
  end


  #список поездов на станции
  def list_trains_on_station
  end


  #создает маршрут
  def create_route

  end

  #редактировать машрут
  def edit_route

  end

  # назначать маршрут
  def set_route

  end
end

a = Main.new

1..2.times do

  a.run_action(a.select_actions)
end

puts a.list_all_stations