require_relative 'oystercard'
class Journey

  attr_reader :entry_station, :exit_station, :journeys

  MINFARE = 1

  def initialize
    @journeys = []
  end

  def entry_station(entry_station)
    @journeys << {:entry_station => entry_station}
  end
  
  def exit_station(exit_station)
    @journeys[-1][:exit_station] = exit_station
  end
  
  def calc_fare
    
  end

  def in_journey?
    !!entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
