require_relative 'journey'
class Oystercard

  MAXBALANCE = 90

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    raise "You cannot exceed a balance of #{MAXBALANCE}" if @balance + amount > MAXBALANCE
    @balance += amount
  end

end
