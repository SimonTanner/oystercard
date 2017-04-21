require './lib/oystercard'
describe Oystercard do
  let(:station) { double :station }

  describe '#balance' do
    it "#balance" do
      expect(subject.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it "#top_up" do
      expect{ subject.top_up(5) }.to change{ subject.balance }.by 5
    end

    it "Raises an error if the balance exceeds 90" do
      expect { subject.top_up(100) }.to raise_error 'You cannot exceed a balance of 90'
    end
  end
end
