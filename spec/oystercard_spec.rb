require 'oystercard'

describe Oystercard do

  let(:my_oyster) {Oystercard.new}
  let(:top_up_amount) {10}

  it "check to see if card has a balance" do
    expect(my_oyster.balance).to eq 0
  end
context "#top_up" do
  it "allows a customer to top-up" do
    expect{my_oyster.top_up(top_up_amount)}.to change{my_oyster.balance}.by top_up_amount
  end

  it "raises error when top-would would make balance exceed £90" do
    expect{my_oyster.top_up(Oystercard::MAX_LIMIT + 1)}.to raise_error "Balance cannot exceed £#{Oystercard::MAX_LIMIT}. Current balance is £#{my_oyster.balance}."
  end
end

    it "deducts fare from a customers' balance" do
        expect{my_oyster.deduct(top_up_amount)}.to change{my_oyster.balance}.by -top_up_amount
    end

    it "initially not to be in journey" do
      is_expected.to_not be_in_journey
    end

    it "updated my card status when i touch in" do
      my_oyster.top_up(top_up_amount)
      my_oyster.touch_in
      expect(my_oyster.in_journey?).to be true
    end

    it "updates my card status when i touch out" do
      my_oyster.top_up(top_up_amount)
      my_oyster.touch_in
      my_oyster.touch_out
      expect(my_oyster.in_journey?).to be false
    end

    it "should not allow a journey, if balance is below min" do
      expect{my_oyster.touch_in}.to raise_error("Your balance is #{my_oyster.balance}, which is below #{Oystercard::MIN_LIMIT}")
    end

end
