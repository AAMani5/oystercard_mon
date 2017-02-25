require 'journey'
describe Journey do
  let(:station) { double :station, zone: 1}

  it "knows if a journey is not complete" do
    expect(subject).not_to be_complete
    #expect(subject.complete?) to eq false
  end

  it 'has a penalty fare by default' do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it 'returns itself when exiting a journey' do
    expect(subject.finish(station)).to eq(subject)
  end

  context 'given an entry station' do
    subject { described_class.new(entry_station: station) }

    it 'has an entry station' do
      expect(subject.entry_station).to eq station
    end

    it 'returns a penalty fare if no exit station given' do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

    context 'given an exit station' do
      let(:other_station) { double :other_station }

      before do
        subject.finish(other_station)
      end

      it 'calculates a fare for zone 1 to zone 1' do
        update_zones(1,1)
        expect(subject.fare).to eq(1)
      end

      it 'calculates a fare for zone 1 to zone 2' do
        update_zones(1,2)
        expect(subject.fare).to eq(2)
      end

      it 'calculates a fare for zone 6 to zone 5' do
        update_zones(6,5)
        expect(subject.fare).to eq(2)
      end

      it 'calculates a fare for zone 6 to zone 2' do
        update_zones(6,2)
        expect(subject.fare).to eq(5)
      end

      it 'knows if a journey is complete' do
        expect(subject).to be_complete
      end

      def update_zones(entry_zone, exit_zone)
        allow(station).to receive(:zone).and_return(entry_zone)
        allow(other_station).to receive(:zone).and_return(exit_zone)
      end

    end
  end
end
