require 'spec_helper'
require 'station'
require 'passenger'

describe Station do
  let(:station) { described_class.new }
  let(:passenger) { Passenger.new }
  let(:train) { double :train }

  it 'lets a passenger touch in' do
    expect(station.passengers_count).to eq(0)
    passenger.top_up(2)
    station.touch_in(passenger)
    expect(station.passengers_count).to eq(1)
  end

  it 'shouldnt let the same passenger touch in twice' do
    passenger.top_up(2)
    station.touch_in(passenger)
    expect { station.touch_in(passenger) }.to raise_error(RuntimeError)
  end

  it 'should only let the passenger enter if its balance is more than 2' do
    expect { station.touch_in(passenger) }.to raise_error(RuntimeError)
    passenger.top_up(2)
    expect { station.touch_in(passenger) }.not_to raise_error
  end

  it 'lets a passenger touch out' do
    passenger.top_up(2)
    station.touch_in(passenger)
    expect(station.passengers_count).to eq(1)
    station.touch_out(passenger)
    expect(station.passengers_count).to eq(0)
  end

  it 'lets us know that a train is already at the station' do
    station.inbound(train)
    expect(station.stationed?(train)).to be true
  end
end
