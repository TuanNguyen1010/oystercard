require 'oystercard'

describe Oystercard do

  subject(:oystercard) { described_class.new }

  it 'should start with a balance of zero' do
    expect(oystercard.balance).to eq(0)
  end

  describe "with maximum balance" do
    before(:each) do
      oystercard.top_up(Oystercard::MAX_BALANCE)
    end


    it "should touch in" do
      oystercard.touch_in
      expect(oystercard.in_journey?).to eq true
    end

    it "should not allow you to touch in if already on a journey" do
      oystercard.touch_in
      expect { oystercard.touch_in }.to raise_error "Card already touched in"
    end

    it "should touch out" do
      oystercard.touch_in
      oystercard.touch_out
      expect(oystercard.in_journey?).to eq false
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
      expect { oystercard.touch_in }.to raise_error "Insufficient balance, cannot touch in: please top up"
    end
  end

  describe "#touch_out" do
    it "should not allow you to touch out if not on a journey" do
      expect { oystercard.touch_out }.to raise_error "Card not touched in"
    end

    it "deduct minimum fare from balance when touching out" do
      oystercard.top_up(10)
      oystercard.touch_in
      expect { oystercard.touch_out }.to change{oystercard.balance}.by(-Oystercard::MIN_FARE)
    end
  end
end
