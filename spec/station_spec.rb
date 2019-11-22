require 'station'

describe Station do
  subject {described_class.new(name: "Shoreditch", zone: 1)}
  it 'displays the name of station' do
    expect(subject.name).to eq("Shoreditch")
  end

  it "displays the zone the station is in" do
    expect(subject.zone).to eq(1)
  end
end
