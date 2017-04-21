require_relative 'oystercard'
class Journey

  attr_reader :entry_station, :exit_station, :journeys


  MINBALANCE = 1
  MINFARE = 1

  def initialize(balance)
    @journeys = []
    @balance = balance
  end


  def touch_in(entry_station)
    fail "Your balance is below #{MINBALANCE} so you cannot travel" if @balance < MINBALANCE
    @entry_station = entry_station
  end

  def touch_out(exit_station)
  	@exit_station = exit_station
  	@journeys << {:entry_station => @entry_station, :exit_station => @exit_station}
  	deduct(MINFARE)
  	@entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
