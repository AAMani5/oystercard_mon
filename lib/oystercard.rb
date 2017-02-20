class Oystercard
  attr_accessor :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    self.balance += 10
  end
end
