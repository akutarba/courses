require_relative 'train'
require_relative 'station'
require_relative 'route'
require_relative 'cargo_train'
require_relative 'passenger_train'
require_relative 'cargo_wagon'
require_relative 'passenger_wagon'

class Main
  def select_actions_menu
    puts(<<-HEREDOC)

      Select action from menu:

      Stations:
        (1)Create station
      Routes:
        (2)Create route
        (3)Edit route
        (4)Set route to the train
      Trains:
        (5)Create train
        (6)Add/remove wagons to train
        (7)Move train to the station
        (8)List trains on selected station

        (9) Exit
    HEREDOC
    run_action(gets.chomp)
  end

  def run_action(key)
    available_actions = { '1' => :create_station, '2' => :select_route_stations,
                          '3' => :edit_route, '4' => :assign_route_to_train,
                          '5' => :create_train_selection, '6' => :edit_train_wagons,
                          '7' => :move_train, '8' => :show_all_trains_on_station,
                          '9' => :goodbye }

    send(available_actions[key]) || send(:select_actions_menu)
  end

  def goodbye
    puts 'Good bye!'
    :exit
  end

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def run_main
    run_action(select_actions_menu) while select_actions_menu != :exit
  end

  attr_accessor :stations, :trains, :routes

  def seed_trains
    @trains.push(PassengerTrain.new('124-01'), CargoTrain.new('M45-01'))
  end

  def seed_stations
    # Some content for tests
    @stations.push(Station.new('SPb'), Station.new('Munich'))
  end

  def seed_routes
    @routes.push(Route.new(stations[0], stations[1]), Route.new(stations[1], stations[0]))
  end

  def seed_testdata
    # This is demo of validation
    seed_stations
    seed_trains
    seed_routes

    # test for acessors
    puts "\nThis is demo of dynamic method _history: "
    train = Train.new('125-01', :passenger)
    train.number = '126-01'
    train.number = '127-01'

    print "Train had numbers: #{train.number_history}\n"

    puts

    # passwagon = PassengerWagon.new(10)
    # cargowagon = CargoWagon.new(300)
    #
    # load_wagon(cargowagon)
    # load_wagon(passwagon)
    #
    # passwagon.take_seat
    # cargowagon.take_volume(100)
    #
    # train1 = select_from_array(@trains)
    # train1.add_wagon(passwagon)
    # train2 = select_from_array(@trains)
    # train2.add_wagon(cargowagon)
    # train1.route = (@routes[0])
    # train2.route = (@routes[1])
  end

  def trains_by_station
    stations.each do |station|
      puts "Station: #{station.name}"
      trains_with_wagons(station)
    end
  end

  private

  # create new station and add to the array of stations
  def create_station
    puts 'Please provide station name (possible letters and numbers):'
    station_name = gets.chomp
    @stations << Station.new(station_name)
    puts "Station '#{station_name}' was created. All stations: #{@stations.join(',')} "
  rescue StandardError => e
    puts e.message
    retry
  end

  # create new train and add to the array of trains
  def create_train_selection
    puts 'Provide new train number in format NNN-NN or NNNNN (N - number or letter): '
    train_number = gets.chomp
    puts 'Select cargo (1) or passenger(2) train: '
    type = gets.chomp.to_i
    create_train(type, train_number)
  end

  def create_train(type, train_number)
    @trains << CargoTrain.new(train_number) if type == 1
    @trains << PassengerTrain.new(train_number) if type == 2
    unless (1..2).cover?(type)
      raise 'Type of train was entered incorrect! Please enter 1 or 2.'
    end
    puts "Train #{train_number} was created. All trains: #{@trains.join(', ')}"
  rescue StandardError => e
    puts e.message
  end

  def create_wagon
    puts 'Select wagon type to create: cargo(1) passenger (2): '
    action = gets.to_i
    case action
    when 1
      CargoWagon.new
    when 2
      PassengerWagon.new
    else
      incorrect_input
    end
  end

  # add wagon to the train according train type
  def edit_train_wagons
    cases = { 1 => :add_wagon_to_train, 2 => :remove_wagon_from_train }
    if @trains.empty?
      puts 'There are no trains yet.'
      return
    end
    puts 'Select action with train: add wagon(1), remove wagon(2)'
    action = gets.chomp.to_i
    send(cases[action.to_s]) || incorrect_input
  end

  def incorrect_input
    puts 'Input was incorrect. Please try again.'
  end

  def add_wagon_to_train
    puts 'Select train: '
    selected_train = select_from_array(@trains)
    new_wagon = create_wagon
    selected_train.add_wagon(new_wagon)
  end

  def remove_wagon_from_train
    selected_train = select_train
    selected_wagon = select_wagon(selected_train)
    selected_train.remove_wagon(selected_wagon)
    puts "In the train #{selected_train} left #{selected_train.wagons} wagons"
  end

  # select element from array (common for stations, trains, routes from main.rb)
  def select_from_array(array)
    return if array.empty?
    array.each.with_index(1) do |element, index|
      puts "#{element} (#{index})"
    end
    array[gets.chomp.to_i - 1]
  end

  def select_route_stations
    if @stations.size < 2
      puts 'There are not enough stations to create a route.'
    else
      puts 'Select first station of route:'
      first_station = select_from_array(@stations)
      puts 'Select last station of route:'
      stations = @stations.reject { |item| item == first_station }
      last_station = select_from_array(stations)
      create_route(first_station, last_station)
    end
  end

  def create_route(first_station, last_station)
    # create route
    @routes << Route.new(first_station, last_station)
    puts "New route was created. See all available: #{@routes}"
  end

  def edit_route
    if @routes.empty?
      puts 'There are no routes to edit'
    else
      cases = { 1 => :add_stations_to_route, 2 => :remove_stations_from_route }
      puts 'Select action with route: add station(1), remove station(2)'
      action = gets.chomp.to_i
      send(cases[action.to_s]) || incorrect_input
    end
  end

  def add_stations_to_route
    # select stations not in route
    puts 'Select route to edit: '
    route = select_from_array(@routes)
    stations = @stations - route.stations
    if stations.empty?
      puts 'All available stations are in the current route.'
    else
      selected_station = select_from_array(stations)
      route.add_station(selected_station)
      puts "Station was added to the route: #{route}. See updated route: #{route.stations}"
    end
  end

  def remove_stations_from_route
    puts 'Select route to edit: '
    route = select_from_array(@routes)
    if route.stations.empty?
      puts "There are no stations to remove in '#{route.name}' route"
    else
      selected_station = select_from_array(route.stations)
      route.remove_station(selected_station)
      puts "Station was removed from route: #{route}. See updated route: #{route.stations}"
    end
  end

  # run trains to next or previous station
  def move_train
    if @trains.empty?
      puts 'There are no trains to move. Please, create one.'
    else
      selected_train = select_from_array(@trains)
      cases = { '1' => :run_next_station, '2' => :run_previous_station }
      puts "Select action for #{selected_train}: move to next(1) or to previous(2) station"
      action = gets.chomp.to_i

      selected_train.send(cases[action.to_s]) || incorrect_input
    end
  end

  def assign_route_to_train
    if @trains.empty?
      puts 'There are no trains to set the route.'
    elsif @routes.empty?
      puts 'There are no routes to assign.'
    else
      selected_train = select_from_array(@trains)
      puts "Choose route to assign #{selected_train}"
      selected_route = select_from_array(@routes)
      # set route
      selected_train.route = selected_route
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

  # @!method select 1 seat or given volume in wagons
  # @!attribute train
  def load_wagon(wagon)
    if wagon.type == :passenger
      wagon.take_seat
      puts "One seat is taken in passenger wagon #{wagon.number}"
    elsif wagon.type == :cargo
      puts 'Cargo wagon selected, enter amount to load:'
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
      'Passenger wagon selected, one seat is taken.'
    elsif selected_wagon.type == :cargo
      puts 'Cargo wagon selected, enter amount to load:'
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
    puts 'Select train: '
    list_all_trains
    selection = gets.chomp.to_i
    trains[selection - 1]
  end

  def select_wagon(train)
    list_all_wagons(train)
    puts ' Select wagon to load  '
    wagon = gets.chomp.to_i -= 1
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

app.select_actions_menu

# app.trains_by_station

class Test
  extend Accessors

  attr_accessor_with_history :a
  strong_attr_accessor :b, Float
end

test = Test.new
test.a = 8
test.a = 9
test.a = 'hello'
puts test.a
puts test.a_history