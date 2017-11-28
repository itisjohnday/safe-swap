require 'rails_helper'

RSpec.describe User, type: :model do
  it 'works' do
    user = User.create(first_name: "John", last_name: "Day")
  end
end
