require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }
  let(:entry_station) {double :station}
  let(:ex_station) {double :station}
  let(:journey) { {entry_station: entry_station, exit_station: ex_station} }

  it 'should start with a balance of zero' do
    expect(oystercard.balance).to eq(0)
  end

  describe "with maximum balance" do
    before(:each) do
      oystercard.top_up(Oystercard::MAX_BALANCE)
    end

    it "should touch in" do
      oystercard.touch_in(entry_station)
      expect(oystercard.in_journey?).to eq true
    end
  end
  describe "#top_up" do

    it "should add £1 to the oystercard" do
      oystercard.top_up(1)
      expect(oystercard.balance).to eq(1)
    end

    it "should add £1 then £2 to the oystercard" do
      oystercard.top_up(1)
      oystercard.top_up(2)
      expect(oystercard.balance).to eq(3)
    end

    it "should throw an exception if the new balance would exceed the limit" do
      maximum_balance = Oystercard::MAX_BALANCE
      oystercard.top_up(maximum_balance)
      message = "Exceeded maximum balance of £#{maximum_balance}"
      expect { oystercard.top_up(1) }.to raise_error { message }
    end
  end

  describe "#in_journey?" do

    it "should return false before touching in" do
      expect(oystercard.in_journey?).to eq false
    end

  end

  describe "#touch_in" do
    it "should raise an error when balance is insufficient" do
      expect { oystercard.touch_in(:station) }.to raise_error "Insufficient balance, cannot touch in: please top up"
    end

end

  describe "#touch_out" do

    it "deduct minimum fare from balance when touching out" do
      oystercard.top_up(10)
      oystercard.touch_in(entry_station)
      expect { oystercard.touch_out(ex_station) }.to change{oystercard.balance}.by(-Oystercard::MIN_FARE)
    end
  end
end
