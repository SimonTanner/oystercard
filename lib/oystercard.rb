require_relative 'journey'

class Oystercard

  attr_reader :journey

  MAXBALANCE = 90
  MINBALANCE = 1

  attr_reader :balance

  def initialize
    @balance = 0
    @journey = Journey.new
  end

  def top_up(amount)
    raise "You cannot exceed a balance of #{MAXBALANCE}" if @balance + amount > MAXBALANCE
    @balance += amount
  end

  def touch_in(entry_station)
    fail "Your balance is below #{MINBALANCE} so you cannot travel" if @balance < MINBALANCE
    @journey.entry_station(entry_station)
      if !@journey.complete?
        penalty charge
      end
  end

  def touch_out(exit_station)
    @journey.exit_station(exit_station)
      if @journey.complete? deduct(fare)
      else penalty charge
      end
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
