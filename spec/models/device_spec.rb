require 'rails_helper'

RSpec.describe Device, type: :model do
  it 'works' do
    device = Device.create(model: "iPhone 7")
  end
end
