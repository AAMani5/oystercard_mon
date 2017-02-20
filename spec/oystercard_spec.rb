require 'oystercard'

describe Oystercard do
    let(:my_oyster) {Oystercard.new}
    it "check to see if card has a balance" do
    expect(my_oyster.balance).to eq 0
    end

    it "allows a customer to top-up" do
      expect(my_oyster).to respond_to :top_up
    end
end
