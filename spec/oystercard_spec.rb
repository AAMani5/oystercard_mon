require 'oystercard'

describe Oystercard do
    it "check to see if card has a balance" do
    expect(subject.balance).to eq 0
  end
end
