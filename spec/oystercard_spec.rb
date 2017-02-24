require 'oystercard'

describe Oystercard do

  let(:my_oyster) {Oystercard.new}
  let(:top_up_amount) {10}
  let (:initial_balance) {0}
  let(:station){ double :station }

  it "check to see if card has a balance" do
    expect(my_oyster.balance).to eq initial_balance
  end

  context "#top_up" do
    it "allows a customer to top-up" do
      expect{my_oyster.top_up(top_up_amount)}.to change{my_oyster.balance}.by top_up_amount
    end

    it "raises error when top-would would make balance exceed £90" do
      expect{my_oyster.top_up(Oystercard::MAX_LIMIT + 1)}.to raise_error "Balance cannot exceed £#{Oystercard::MAX_LIMIT}. Current balance is £#{my_oyster.balance}."
    end
  end

    # it "deducts fare from a customers' balance" do
    #     expect{my_oyster.balance(top_up_amount)}.to change{my_oyster.balance}.by -top_up_amount
    # end

    it "initially not to be in journey" do
      is_expected.to_not be_in_journey
    end

    it "updated my card status when i touch in" do
      my_oyster.top_up(top_up_amount)
      my_oyster.touch_in(station)
      expect(my_oyster.in_journey?).to be true
    end

    it "updates my card status when i touch out" do
      my_oyster.top_up(top_up_amount)
      my_oyster.touch_in(station)
      my_oyster.touch_out(station)
      expect(my_oyster.in_journey?).to be false
    end

    it "checks that touching out reduces balance by the correct amount" do
        my_oyster.top_up(top_up_amount)
        my_oyster.touch_in(station)
        expect{my_oyster.touch_out(station)}.to change{my_oyster.balance}.by -Oystercard::MIN_FARE #let fare
    end

    it "should not allow a journey, if balance is below min" do
      expect{my_oyster.touch_in(station)}.to raise_error("Your balance is #{my_oyster.balance}, which is below #{Oystercard::MIN_LIMIT}")
    end

    let(:entry_station) { double :station }
    let(:exit_station) { double :station }

    it 'has an empty list of journeys by default' do
      expect(my_oyster.journey_log.journeys).to be_empty
    end

    let(:journey){ {entry_station: entry_station, exit_station: exit_station} }

    it 'stores a journey' do
      my_oyster.top_up(top_up_amount)
      my_oyster.touch_in(entry_station)
      my_oyster.touch_out(exit_station)
      expect(my_oyster.journey_log.journeys.last.entry_station).to eq entry_station
      expect(my_oyster.journey_log.journeys.last.exit_station).to eq exit_station
    end

    it "creates journey when touched in & stores it in an attribute" do
      my_oyster.top_up(top_up_amount)
      my_oyster.touch_in(entry_station)
      expect(my_oyster.journey_log.journeys.last.entry_station).to eq entry_station
      my_oyster.touch_out(exit_station)
      expect(my_oyster.journey_log.journeys.last.exit_station).to eq exit_station
    end

    it "no touch in, but touched out" do
      my_oyster.top_up(top_up_amount)
      expect{my_oyster.touch_out(exit_station)}. to change{my_oyster.balance}.by(-Journey::PENALTY_FARE)
    end

    it "no touch out, but touched in" do
      my_oyster.top_up(top_up_amount)
      my_oyster.touch_in(entry_station)
      expect{my_oyster.touch_in(entry_station)}.to change{my_oyster.balance}.by(-Journey::PENALTY_FARE)

    end

end
