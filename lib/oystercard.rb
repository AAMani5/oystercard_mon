class Oystercard
  attr_accessor :balance, :in_journey
  MAX_LIMIT = 90

  def initialize
    @balance = 0
    @in_journey = false
  end

  def top_up(amount)
    fail "Balance cannot exceed £#{MAX_LIMIT}. Current balance is £#{balance}." if (amount + balance) > MAX_LIMIT
    self.balance += amount
  end

  def deduct(amount)
    self.balance -= amount
  end

  def touch_in
    self.in_journey = true
  end

  def touch_out
    self.in_journey = false
  end

  def in_journey?
    in_journey
  end

end
