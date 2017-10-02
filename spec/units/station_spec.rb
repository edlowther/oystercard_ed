require 'station'

describe Station do
  it "can take a name" do
    seven_sisters = Station.new "Seven Sisters"
    expect(seven_sisters.name).to eq "Seven Sisters"
  end
end
