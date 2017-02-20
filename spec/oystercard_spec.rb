require 'oystercard'

describe Oystercard do
    let(:my_oyster) {Oystercard.new}
    it "check to see if card has a balance" do
    expect(my_oyster.balance).to eq 0
    end

    it "allows a customer to top-up" do
      expect{my_oyster.top_up(10)}.to change{my_oyster.balance}.by 10
    end

    it "raises error when top-would would make balance exceed £90" do
      expect{my_oyster.top_up(91)}.to raise_error "Balance cannot exceed £#{Oystercard::MAX_LIMIT}. Current balance is £#{my_oyster.balance}."
    end

    it "deducts fare from a customers' balance" do
        expect{my_oyster.deduct(10)}.to change{my_oyster.balance}.by -10
    end

end
