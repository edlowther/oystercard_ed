require 'station'

describe Station do
  it "can take a name" do
    seven_sisters = Station.new "Seven Sisters", 3
    expect(seven_sisters.name).to eq "Seven Sisters"
  end
  it "can be assigned to a zone" do
    seven_sisters = Station.new "Pimlico", 1
    expect(seven_sisters.zone).to eq 1
  end
end
