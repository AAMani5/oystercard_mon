require 'oystercard'

describe Oystercard do
    let(:my_oyster) {Oystercard.new}
  it "check to see if card has a balance" do
    expect(my_oyster.balance).to eq 0
  end
context "#top_up" do
  it "allows a customer to top-up" do
    expect{my_oyster.top_up(10)}.to change{my_oyster.balance}.by 10
  end

  it "raises error when top-would would make balance exceed £90" do
    expect{my_oyster.top_up(91)}.to raise_error "Balance cannot exceed £#{Oystercard::MAX_LIMIT}. Current balance is £#{my_oyster.balance}."
  end
end

    it "deducts fare from a customers' balance" do
        expect{my_oyster.deduct(10)}.to change{my_oyster.balance}.by -10
    end

    it "initially not to be in journey" do
      is_expected.to_not be_in_journey
    end

    it "updated my card status when i touch in" do
      my_oyster.top_up(10)
      my_oyster.touch_in
      expect(my_oyster.in_journey?).to be true
    end

    it "updates my card status when i touch out" do
      my_oyster.top_up(10)
      my_oyster.touch_in
      my_oyster.touch_out
      expect(my_oyster.in_journey?).to be false
    end

    it "should not allow a journey, if balance is below min" do
      expect{my_oyster.touch_in}.to raise_error("Your balance is #{my_oyster.balance}, which is below #{Oystercard::MIN_LIMIT}")
    end

end
