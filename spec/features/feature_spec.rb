require 'oystercard'

feature 'Getting started' do
  card = Oystercard.new
  card.top_up 20
  fare = 2.8
  card.deduct fare
end
