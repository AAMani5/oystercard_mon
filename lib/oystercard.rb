class Oystercard
  attr_accessor :balance
  MAX_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "Balance cannot exceed £#{MAX_LIMIT}. Current balance is £#{balance}." if (amount + balance) > MAX_LIMIT
    self.balance += amount
  end

  def deduct(amount)
    self.balance -= amount
  end

end
