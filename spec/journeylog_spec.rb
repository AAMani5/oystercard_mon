require 'journeylog'

describe JourneyLog do

  let(:journey){ double :journey, entry_station: "wc", exit_station: "ae"  } #this may need to have some methods
  let(:station){ double :station}
  let(:journey_class){double :journey_class, new: journey}
  subject {described_class.new(journey_class: journey_class)}

  describe '#start' do
    it 'starts a journey' do
      expect(journey_class).to receive(:new).with(entry_station: station)
      subject.start(station)
    end

    it 'records a journey' do
      allow(journey_class).to receive(:new).and_return journey
      subject.start(station)
      expect(subject.journeys).to include journey
    end
  end

  describe '#finish' do
    it 'finishes a journey' do
      expect(journey).to receive(:finish).with(station)
      subject.finish(station)
    end

    it 'records a journey' do
      allow(journey).to receive(:finish)#.and_return journey
      subject.start(station)
      subject.finish(station)
      expect(subject.journeys).to include journey
    end
  end
end
