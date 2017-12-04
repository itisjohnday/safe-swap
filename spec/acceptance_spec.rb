require 'rails_helper'


describe 'all the things' do
  it 'works' do
    buyer = User.create!(first_name: "John", last_name: "Doe", email: "john.doe@email.com", password: "123456")
    seller = User.create!(first_name: "John", last_name: "Doe", email: "john.doe1@email.com", password: "123456")
    device = Device.create!(seller_id: seller.id)
    expect(device.seller).to eq(seller)
  end

  it '' do

  end
end