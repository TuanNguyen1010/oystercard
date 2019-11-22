require 'journey'

describe Journey do
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  describe "#start" do
    it "when the journey start and saves the entry station" do
      subject.start(entry_station)
      expect(subject.entry_station).to eq(entry_station)
    end
  end

  describe "#end" do
    it "saves the exit station when end journey" do
      subject.start(entry_station)
      subject.end(exit_station)
      expect(subject.exit_station).to eq(exit_station)
    end
  end

  describe "#fare" do
    it "returns #{Journey::PENALTY_FARE} when entry station = nil" do
      allow(subject).to receive(:exit_station) {"shoreditch"}
      expect(subject.fare).to eq(Journey::PENALTY_FARE)
    end

    it "returns #{Journey::PENALTY_FARE} when exit station = nil" do
      allow(subject).to receive(:entry_station) {"Makers"}
      expect(subject.fare).to eq(Journey::PENALTY_FARE)
    end

    it "returns #{Journey::MIN_FARE} when there is start journey and end journey" do
      allow(subject).to receive(:entry_station) {"Makers"}
      allow(subject).to receive(:exit_station) {"Shoreditch"}
      expect(subject.fare).to eq(Journey::MIN_FARE)
    end
  end

  describe "#complete?" do
    it "returns true if there is entry station and exit station" do
      subject.start(entry_station)
      subject.end(exit_station)
      expect(subject.complete?).to eq(true)
    end

    it "returns false if there is no exit station" do
      subject.start(entry_station)
      expect(subject.complete?).to eq(nil)
    end
  end
end
