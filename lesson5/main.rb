=begin

Задание:

Разбить программу на отдельные классы (каждый класс в отдельном файле)
Разделить поезда на два типа PassengerTrain и CargoTrain, сделать родителя для классов, который будет содержать общие методы и свойства
Определить, какие методы могут быть помещены в private/protected и вынести их в такую секцию. В комментарии к методу обосновать,
почему он был вынесен в private/protected
Вагоны теперь делятся на грузовые и пассажирские (отдельные классы). К пассажирскому поезду можно прицепить только пассажирские,
к грузовому - грузовые.
При добавлении вагона к поезду, объект вагона должен передаваться как аругмент метода и сохраняться во внутреннем массиве поезда,
 в отличие от предыдущего задания, где мы считали только кол-во вагонов. Параметр конструктора "кол-во вагонов" при этом можно удалить.

Добавить текстовый интерфейс:

Создать программу в файле main.rb, которая будет позволять пользователю через текстовый интерфейс делать следующее:
     - Создавать станции
     - Создавать поезда
     - Создавать маршруты и управлять станциями в нем (добавлять, удалять)
     - Назначать маршрут поезду
     - Добавлять вагоны к поезду
     - Отцеплять вагоны от поезда
     - Перемещать поезд по маршруту вперед и назад
     - Просматривать список станций и список поездов на станции
=end

require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

class Main

  def select_actions_menu
    puts(<<~HEREDOC)

      Select action from menu:

      Stations:
        (1)Create station
        (2)List of stations
      Routes:
        (3)Create route
        (4)Edit route
        (5)Set route to the train
      Trains:
        (6)Create train
        (7)Add/remove wagons to train
        (8)Move train to the station
        (9)List trains on selected station

        (10) Exit
    HEREDOC
    run_action(gets.chomp)
  end

  def run_action(action)
    case action.to_i
    when 1
      create_station
    when 2
      list_all_stations
    when 3
      create_route
    when 4
      edit_route
    when 5
      assign_route_to_train
    when 6
      create_train
    when 7
      edit_train_wagons
    when 8
      move_train
    when 9
      show_all_trains_on_station
    when 10
      puts 'Good bye!'
      return :exit
    else
      select_actions_menu
    end
  end


  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def run_main
    while select_actions_menu != :exit
      run_action(select_actions_menu)
    end
  end

  attr_accessor :stations, :trains, :routes


  def seed_testdata
# Some content for tests
    @stations.push(Station.new("SPb"), Station.new("Munich"))

    train1 = PassengerTrain.new("124-01")
    train2 = PassengerTrain.new("123-02")
    train3 = CargoTrain.new("M45-01")
    train4 = CargoTrain.new("M46-02")

    pass_wagon_1 = PassengerWagon.new(10)
    pass_wagon_2 = PassengerWagon.new(20)
    cargo_wagon_1 = CargoWagon.new(300)
    cargo_wagon_2 = CargoWagon.new(400)

    load_wagon(cargo_wagon_1)
    load_wagon(pass_wagon_1)

    pass_wagon_1.take_seat
    pass_wagon_2.take_seat

    cargo_wagon_1.take_volume(100)
    cargo_wagon_2.take_volume(200)

    train1.add_wagon(pass_wagon_1)
    train2.add_wagon(pass_wagon_2)
    train3.add_wagon(cargo_wagon_1)
    train4.add_wagon(cargo_wagon_2)

    @routes.push(Route.new(stations[0], stations[1]), Route.new(stations[1], stations[0]))

    train1.route = (@routes[0])
    train2.route = (@routes[1])
    train3.route = (@routes[0])
    train4.route = (@routes[1])
    @trains.push(train1, train2, train3, train4)

    # load_wagon(train1) #тест для первого поезда

  end

  def trains_by_station
    stations.each_with_index do |station|
      puts "Station: #{station.name}"
      trains_with_wagons(station)
    end
  end

  private

# создает новую станцию и добавляет ее в массив станций
  def create_station
    puts 'Please provide station name (possible letters and numbers):'
    station_name = gets.chomp
    @stations << Station.new(station_name)
    puts "Station '#{station_name}' was created. All stations: #{@stations.join(',')} "
  rescue => e
    puts e.message
    retry
  end

#создает новый поезд с указанным типом, добавляет в массив поездов
  def create_train
    puts 'Provide new train number in format NNN-NN or NNNNN (N - number or letter): '
    train_number = gets.chomp
    puts "Select cargo (1) or passenger(2) train: "
    type = gets.chomp.to_i
    if type == 1
      @trains << CargoTrain.new(train_number)
    end
    if type == 2
      @trains << PassengerTrain.new(train_number)
    end
    unless (1..2).include?(type)
      raise "Type of train was entered incorrect! Please enter 1 or 2."
    end
    puts "Train #{train_number} was created. All trains: #{@trains.join(', ')}"
  rescue => e
    puts e
    retry
  end


  def create_wagon
    puts "Select wagon type to create: cargo(1) passenger (2): "
    action = gets.to_i
    case action
    when 1
      CargoWagon.new
    when 2
      PassengerWagon.new
    else
      puts "Input is incorrect. Please provide the correct type of wagon."
    end

  end

#добавляем вагон к поезду согласно типу поезда - соответствующий тип вагона
  def edit_train_wagons
    if @trains.empty?
      puts 'There are no trains yet.'
      return
    end
    puts "Select train: "
    selected_train = select_from_array(@trains)
    puts "Select action with train: add wagon(1), remove wagon(2)"
    action = gets.chomp.to_i
    case action
    when 1 then
      new_wagon = create_wagon
      selected_train.add_wagon(new_wagon)
    when 2 then
      puts "Select wagon from available: "
      selected_wagon = select_from_array(selected_train.wagons)
      selected_train.remove_wagon(selected_wagon)
      puts "In the train #{selected_train} left #{selected_train.wagons} wagons"
    else
      puts "Input was incorrect. Please try again."
    end
  end


# общий метод для выбора элемента из массива (для массива станций, маршрутов и поездов из main.rb)
  def select_from_array(array)
    return if array.empty?
    array.each.with_index(1) do |element, index|
      puts "#{element} (#{index})"
    end
    array[gets.chomp.to_i - 1]
  end

  def create_route
    if @stations.size < 2
      puts 'There are not enough stations to create a route.'
    else
      puts 'Select first station of route:'

      #выбираю начало маршрута
      first_station = select_from_array(@stations)
      puts 'Select last station of route:'

      #выбираю массив начиная с выбранной пользователем первой станции
      stations = @stations.reject {|item| item == first_station}
      last_station = select_from_array(stations)

      #создаю маршрут
      @routes << Route.new(first_station, last_station)
      puts "New route was created. See all available: #{@routes}"
    end
  rescue => e
    puts e.message
    retry
  end

  def edit_route
    if @routes.empty?
      puts 'There are no routes to edit'
    else
      puts 'Select route to edit: '
      selected_route = select_from_array(@routes)
      puts "Select action with route: add station(1), remove station(2)"
      action = gets.chomp.to_i
      case action
      when 1 then
        add_stations_to_route(selected_route)
      when 2 then
        remove_stations_from_route(selected_route)
      else
        puts 'Input was incorrect. PLease try again.'
      end
    end
  end


  def add_stations_to_route(route)
    # делаем выборку станций которые не в маршруте
    stations = @stations - route.stations
    if stations.empty?
      puts 'All available stations are in the current route.'
    else
      selected_station = select_from_array(stations)
      route.add_station(selected_station)
      puts "Station was added to the route: #{route}. See updated route: #{route.stations}"
    end
  end


  def remove_stations_from_route(route)
    if route.stations.empty?
      puts "There are no stations to remove in '#{route.name}' route"
    else
      selected_station = select_from_array(route.stations)
      route.remove_station(selected_station)
      puts "Station was removed from route: #{route}. See updated route: #{route.stations}"
    end
  end

# отправить поезд на след или предыдущую станцию маршрута
  def move_train
    if @trains.empty?
      puts 'There are no trains to move. Please, create one.'
    else
      puts 'Select train: '
      selected_train = select_from_array(@trains)

      puts "Select action for #{selected_train}: move to next(1) or to previous(2) station"
      action = gets.chomp.to_i
      case action
      when 1 then
        selected_train.run_next_station
      when 2 then
        selected_train.run_previous_station
      else
        "Entered option was not found."
      end
    end
  end

# назначить маршрут поезду
  def assign_route_to_train
    if @trains.empty?
      puts 'There are no trains to set the route.'
    elsif @routes.empty?
      puts 'There are no routes to assign.'
    else
      puts 'Choose train to assign the route: '
      selected_train = select_from_array(@trains)
      puts "Choose route to assign #{selected_train}"
      selected_route = select_from_array(@routes)
      #  устанавливаю маршрут
      selected_train.route = (selected_route)
      puts "Train #{selected_train} have #{selected_route} now."
    end
  end


  def trains_with_wagons(station = nil)
    station ||= select_station
    station.each_train do |train|
      puts "  Train number: #{train.number}, Type: #{train.type}"
      list_all_wagons(train)
    end
  end

# @!method занимает место или объем в вагоне
# @!attribute поезд
  def load_wagon(wagon)
    if wagon.type == :passenger
      wagon.take_seat
      puts "One seat is taken in passenger wagon #{wagon.number}"
    elsif wagon.type == :cargo
      puts "Cargo wagon selected, enter amount to load:"
      amount = gets.chomp.to_f
      wagon.take_volume(amount)
      puts "#{amount}l is loaded in cargo wagon #{wagon.number}"
    end
  end

  def load_wagon_in_train
    selected_train ||= select_train
    selected_wagon ||= select_wagon(selected_train)
    if selected_wagon.type == :passenger
      selected_wagon.take_seat
      "Passenger wagon selected, one seat is taken."
    elsif selected_wagon.type == :cargo
      puts "Cargo wagon selected, enter amount to load:"
      amount = gets.chomp.to_f
      selected_wagon.take_volume(amount)
    end
  end
  def list_all_trains
    trains.each_with_index(1) do |train, i|
      puts "#{train.number} (#{i})"
    end
  end

  def select_train
    puts "Select train: "
    list_all_trains
    selection = gets.chomp.to_i
    trains[selection - 1]
  end

  def select_wagon(train)
    list_all_wagons(train)
    puts " Select wagon to load  "
    wagon = gets.chomp.to_i - 1
    train.wagons[wagon]
  end


  def list_all_wagons(selected_train = nil)
    selected_train ||= select_train
    selected_train.each_wagon do |wagon|
      puts "    Wagon number #{wagon.number}, type: #{wagon.type}, #{wagon.free_space}, #{wagon.taken_space}"
    end
  end

end


app = Main.new

app.seed_testdata



# Используя созданные в рамках задания методы, написать код, который перебирает последовательно все станции и для
# каждой станции выводит список поездов в формате:
#       - Номер поезда, тип, кол-во вагонов

#    А для каждого поезда на станции выводить список вагонов в формате:
#       - Номер вагона (можно назначать автоматически), тип вагона, кол-во свободных и занятых мест
# (для пассажирского вагона) или кол-во свободного и занятого объема (для грузовых вагонов).

app.trains_by_station
