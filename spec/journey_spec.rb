require './lib/journey'
require './lib/oystercard'

describe Journey do

  let(:station) { double :station }
  card = Oystercard.new
  
  describe '#touch_in' do

    before(:example) { card.top_up(Journey::MINFARE) }

    it 'should let us touch_in a card' do
      is_expected.to respond_to(:touch_in)
    end

    it "should return true when we touch_in" do
      subject.touch_in(station)
      expect(subject).to be_in_journey
    end

    it "should remember the entry station after we touch in" do
      subject.touch_in(station)
      expect(subject.entry_station).to eq station
    end
  end

  describe '#touch_in_without_balance' do
    it "should raise an error if we try to touch in with a balance of less than 1" do
      expect { subject.touch_in("station") }.to raise_error "Your balance is below 1 so you cannot travel"
    end
  end

  describe '#touch_out' do

    before(:example) { card.top_up(1) }

    it 'should let us touch_out a card' do
      is_expected.to respond_to(:touch_out)
    end

    it "should return false when we touch_out" do
      subject.touch_out(station)
      expect(subject).not_to be_in_journey
    end

    it "should deduct money when a user touches out" do
      expect { subject.touch_out(station) }.to change{ subject.balance}.by (-Journey::MINFARE)
    end

    it "should 'forget' the entry station after we touch out" do
      subject.touch_in(station)
      subject.touch_out(station)
      expect(subject.entry_station).to eq nil
    end
  end


  describe '#in_journey?' do

    before(:example) { card.top_up(1) }

    it "should tell us if we have touched in and touched out" do
      subject.touch_out(station)
      subject.in_journey?.should be false
    end

    it "should return true when entry_station is not set to nil" do
      subject.touch_in(station)
      subject.in_journey?.should be true
    end

    it "should return false when entry_station is set to nil" do
      subject.in_journey?.should be false
    end
  end

  describe '#journeys' do

    let(:journey) { {entry_station: entry_station, exit_station: exit_station} }
    let(:entry_station) { double :entry_station }
    let(:exit_station) { double :exit_station }

    before(:example) { card.top_up(1) }

    it "should contain an empty list upon instantiation" do
      expect(subject.journeys).to be_empty
    end

    it "should store a journey after touching in and out" do
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject.journeys).to include journey
    end

  end

end
