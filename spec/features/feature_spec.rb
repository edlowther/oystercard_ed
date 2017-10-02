require 'oystercard'

feature 'Getting started' do
  card = Oystercard.new
  card.top_up 20
  card.touch_out
  p card.balance
end
