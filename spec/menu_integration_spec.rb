require 'dish'
require 'menu'

RSpec.describe 'Menu-Dish Integration' do
  context 'after adding a dish' do
    it 'can display a menu' do
      dish = Dish.new('item_1', 1)
      menu = Menu.new
      menu.add(dish)
      expect(menu.show).to eq [{ name: 'item_1', price: 1 }]
    end
  end
end
